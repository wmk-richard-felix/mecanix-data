IMPORT STD, Common;

EXPORT modSuperFile(STRING sFileName) := MODULE

  SHARED BOOLEAN bSuperFileExists := STD.File.SuperFileExists(sFileName);

  EXPORT macWrapInSFTransaction(action) := FUNCTIONMACRO
    RETURN SEQUENTIAL(STD.File.StartSuperFileTransaction(), action, STD.File.FinishSuperFileTransaction());
  ENDMACRO;  

  EXPORT fConsolidateSubFileName(STRING sSuffix = '::consolidated') := FUNCTION
    sDate := (STRING) STD.Date.CurrentDate() : INDEPENDENT;
    sTime := (STRING) STD.Date.CurrentTime() : INDEPENDENT;
    RETURN sFileName + '::' + sDate + sTime + sSuffix;
  END;
  
  EXPORT fBackupFileName() := FUNCTION
    sDate := (STRING) STD.Date.CurrentDate() : INDEPENDENT;
    sTime := (STRING) STD.Date.CurrentTime() : INDEPENDENT;
    RETURN '~backup::' + sDate + sTime + '::' + IF(sFilename[1] = '~', sFileName[2..], sFileName);
  END;
  
  EXPORT aCreate() := FUNCTION
    aCreateSF := STD.File.CreateSuperFile(sFileName,, TRUE);
    RETURN IF(NOT bSuperFileExists, aCreateSF);
  END;
  
  EXPORT aDelete() := FUNCTION
    aDeleteSF := STD.File.DeleteSuperFile(sFileName, TRUE);
    RETURN IF(bSuperFileExists, aDeleteSF);
  END;

  EXPORT aAppend(STRING sSubFileName) := FUNCTION
    RETURN IF(bSuperFileExists, STD.File.AddSuperFile(sFileName, sSubFileName), Common.modErrors.aGenerateFail(5001, sFileName));
  END;
  
  EXPORT aRemove(STRING sSubFileName, BOOLEAN bRemoveFromDisk = TRUE) := FUNCTION
    RETURN STD.File.RemoveSuperFile(sFileName, sSubFileName);
  END;
  
  EXPORT fClear(BOOLEAN bRemoveSubFilesFromDisk) := FUNCTION
    aFailSuperFileDoesntExist := Common.modErrors.aGenerateFail(5002, 'The Superfile ' + sFilename + ' does not exist.');
    aClearSuperFile := STD.File.ClearSuperFile(sFileName, bRemoveSubFilesFromDisk);
    RETURN IF(bSuperFileExists, aClearSuperFile, aFailSuperFileDoesntExist);
  END;

  EXPORT aRemoveSubfilesWithoutPattern(STRING sPattern, BOOLEAN bRemoveSubFilesFromDisk) := FUNCTION
    dFiles := NOTHOR(Std.File.SuperFileContents(sFilename))(NOT REGEXFIND(sPattern, name));
    RETURN NOTHOR(APPLY(GLOBAL(dFiles, FEW),
        Std.File.RemoveSuperFile(sFilename, '~' + name, bRemoveSubFilesFromDisk)));
  END;

  EXPORT aRemoveSubfilesWithPattern(STRING sPattern, BOOLEAN bRemoveSubFilesFromDisk) := FUNCTION
    dFiles := NOTHOR(Std.File.SuperFileContents(sFilename))(REGEXFIND(sPattern, name));
    RETURN NOTHOR(APPLY(GLOBAL(dFiles, FEW),
        Std.File.RemoveSuperFile(sFilename, '~' + name, bRemoveSubFilesFromDisk)));
  END;
  
  EXPORT aClearConsolidatedSuperfile() := SEQUENTIAL(aRemoveSubfilesWithPattern('::consolidated$', TRUE), 
    aRemoveSubfilesWithoutPattern('::currentweek$', FALSE));
    
  EXPORT macRetrieveData(sLogicalFileName, lRecordDefinition) := FUNCTIONMACRO
    RETURN DATASET(sLogicalFileName, lRecordDefinition, FLAT, OPT);
  ENDMACRO;
  
  EXPORT macConsolidate(sFileName, lRecordDefinition, sSubFileName) := FUNCTIONMACRO
    IMPORT Common, Std, ETL;

    // Take snapshot and consolidate
    STRING sSnapshotName := Common.modSuperfile(sFileName).fConsolidateSubFileName('::___temp___snapshot___');
    dOriginalSubfiles := NOTHOR(STD.File.SuperFileContents(sFileName));
    aTakeSnapshot := SEQUENTIAL(// Create if not exists yet
      STD.File.CreateSuperFile(sSnapshotName, 0, 1),
      STD.File.StartSuperFileTransaction(),
      STD.File.ClearSuperFile(sSnapshotName, FALSE),
      NOTHOR(APPLY(GLOBAL(dOriginalSubFiles, FEW),
          STD.File.AddSuperFile(sSnapshotName, '~' + name))),
      STD.File.FinishSuperFileTransaction());
    dData := DISTRIBUTE(DATASET(sSnapshotName, lRecordDefinition, THOR)) : INDEPENDENT;
    // Output consolidated file
    sConsolidatedFileName := Common.modSuperfile(sFileName).fConsolidateSubFileName() : INDEPENDENT;
    aWriteSuperFileToDisk := OUTPUT(dData,, sConsolidatedFileName, OVERWRITE, COMPRESSED, EXPIRE(ETL.Common.modConstants.uEtlDatasetExpirationDays));    

    // Consolidate superfile and remove tmp files
    dSnapshotSubfiles := NOTHOR(STD.File.SuperFileContents(sSnapshotName));
    aConsolidate := SEQUENTIAL(STD.File.StartSuperFileTransaction(),
      // Unlink from input superfile but leave on disk
      NOTHOR(APPLY(GLOBAL(dSnapshotSubFiles, FEW),
          STD.File.RemoveSuperFile(sFileName, '~' + name, FALSE)));
      // Unlink from snapshot and remove "consolidated" from disk
      Common.modSuperFile(sSnapshotName).aClearConsolidatedSuperfile(),
      // Delete snapshot
      Std.File.DeleteSuperFile(sSnapshotName),
      // Add consolidated content to the input superfile
      STD.File.AddSuperFile(sFileName, sConsolidatedFileName);
      // Verify integrity
      IF(COUNT(dData) <> COUNT(DATASET(sConsolidatedFileName, lRecordDefinition, THOR)),
        Common.modCriticalError.aGenerateFail(5034)),
      STD.File.FinishSuperFileTransaction());

    RETURN IF(COUNT(dOriginalSubfiles) > 1,
      ORDERED(aTakeSnapshot,
        aWriteSuperFileToDisk,
        aConsolidate));
  ENDMACRO;

  EXPORT fCount() := FUNCTION
    RETURN STD.File.GetSuperFileSubCount(sFileName);
  END;

END;