IMPORT ETL, Common, Python, Std;

EXPORT modKey := MODULE

  EXPORT macCreateEmptyKey(sSuperfile, sEmptyDataName, dEmptyData, kEmptyData) := FUNCTIONMACRO
    RETURN SEQUENTIAL(BUILD(kEmptyData, COMPRESSED(LZW)),
      STD.File.StartSuperFileTransaction(),
      Common.modSuperFile(sSuperfile).aAppend(sEmptyDataName),
      STD.File.FinishSuperFileTransaction());
  ENDMACRO;

  EXPORT macBuildFromScratch(sSF, sLF, kData, bUseSuperfileTransaction, bDeleteSubfile = TRUE, bBuildLocally = FALSE) := FUNCTIONMACRO
    IMPORT Std, ETL;

    aFailInexistentSF := Common.modErrors.aGenerateFail(5001, sSF);
    RETURN SEQUENTIAL(
      IF(bBuildLocally, 
        BUILD(kData, sLF, OVERWRITE, COMPRESSED(LZW), LOCAL), 
        BUILD(kData, sLF, OVERWRITE, COMPRESSED(LZW))
      );
      IF(NOT Std.File.SuperFileExists(sSF), aFailInexistentSF);
      IF(bUseSuperfileTransaction, Std.File.StartSuperFileTransaction());
      // Clears if exists.
      STD.File.ClearSuperFile(sSF, bDeleteSubfile);
      // Adds the logical file index to the superfile.
      Common.modSuperfile(sSF).aAppend(sLF);
      IF(bUseSuperfileTransaction, Std.File.FinishSuperFileTransaction()));
  ENDMACRO;

  EXPORT fGetNames(STRING sSystemPrefix, STRING sKeyName) := MODULE
    EXPORT STRING sKeySF := '~' + sSystemPrefix + '::' + sKeyName + '::key::sf';
    EXPORT STRING sKeyLF(STRING sVersion = '') := '~' + sSystemPrefix + '::' + sKeyName + '::key' + IF(sVersion = '', '', '::' + sVersion);
    EXPORT STRING sDataLF(STRING sVersion = '') := '~' + sSystemPrefix + '::' + sKeyName + '::data' + IF(sVersion = '', '', '::' + sVersion);
    EXPORT STRING sDataSF := '~' + sSystemPrefix + '::' + sKeyName + '::data::sf';
    EXPORT STRING sBase := sSystemPrefix + '::' + sKeyName;
  END;
END;