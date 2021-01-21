EXPORT macCreateIndex(dUDMDataset, sKeyLayoutName, sAttrNames, sKeyName, sDedupCriteria, sSortCriteria) := MACRO
  IMPORT STD;

  #UNIQUENAME(sTimestamp);
  #UNIQUENAME(sKeyLF);
  #UNIQUENAME(sKeySF);
  #UNIQUENAME(sAttrNameRx);
  #SET(sAttrNameRx, REGEXREPLACE(',', TRIM(sAttrNames), '_'));
  SHARED STRING %sTimestamp% := (STRING) Common.modFunctions.fCurrentDateTime();
  // Superfile name
  SHARED STRING %sKeySF% := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem , sKeyName, %'sAttrNameRx'% + '::key::sf');
  // Logical file name
  SHARED STRING %sKeyLF% := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem , skeyName, %'sAttrNameRx'% + '::key::' + %sTimestamp%) : INDEPENDENT;
  EXPORT STRING #EXPAND('sKeyLF_' + %'sAttrNameRx'%) := %sKeyLF%;
  EXPORT STRING #EXPAND('sKeySF_' + %'sAttrNameRx'%) := %sKeySF%;

  // If a key layout name and/or a dedup criteria are informed, PROJECT and/or DEDUP the data
  #UNIQUENAME(dNarrowed);
  #UNIQUENAME(dOptimized);
  #UNIQUENAME(dSorted);
  #UNIQUENAME(sChosenSortCriteria);
  #UNIQUENAME(dDataFiltered);

  %dDataFiltered% := dUDMDataset;

  #IF( sKeyLayoutName <> '')
    %dNarrowed% := PROJECT(%dDataFiltered%, #EXPAND(sKeyLayoutName)); 
  #ELSE
    %dNarrowed% := %dDataFiltered%;
  #END

  // If only sSortCriteria is defined
  #IF( sSortCriteria <> '' AND sDedupCriteria = '' )
    SHARED %dOptimized% := %dNarrowed%;
  #END
  
  // If only sDedupCriteria is defined
  #IF( sSortCriteria = '' AND sDedupCriteria <> '' )
    SHARED %dOptimized% := DEDUP(
      SORT(
        DISTRIBUTE(%dNarrowed%, HASH64(#EXPAND(sDedupCriteria))),
        #EXPAND(sDedupCriteria), LOCAL),
      #EXPAND(sDedupCriteria), LOCAL); 
  #END
  
  // If both criterias are defined
  #IF( sSortCriteria <> '' AND sDedupCriteria <> '' )    
    SHARED %dOptimized% :=  DEDUP(
      SORT(
        DISTRIBUTE(%dNarrowed%, HASH64(#EXPAND(sDedupCriteria))),
        #EXPAND(sSortCriteria), LOCAL),
      #EXPAND(sDedupCriteria), LOCAL);  
  #END
  
  // If both criterias are empty
  #IF( sSortCriteria = '' AND sDedupCriteria = '' )
    SHARED %dOptimized% := %dNarrowed%;
  #END

  // The INDEX file is added to a superfile, through which the external world references the key
  #UNIQUENAME(kData);
  SHARED %kData% := INDEX(%dOptimized%, {#EXPAND(sAttrNames)}, {%dOptimized%}, %sKeySF%);
  // Key Superfile. The key attribute is named "kData_<indexing attribute>"
  EXPORT #EXPAND( 'kData_' + %'sAttrNameRx'%) := %kData%;
  EXPORT #EXPAND( 'lLayoutKey_' + %'sAttrNameRx'%) := RECORDOF(%kData%);

  // Action to force-build the key. Forced is done only on ad-hoc key builds (see \UDM\BWR\BWR_TestUDMIndexes.ecl)
  EXPORT #EXPAND( 'aForceBuildKey_' + %'sAttrNameRx'%) := Common.modKey.macBuildFromScratch(%sKeySF%, %sKeyLF%, %kData%, TRUE);

  // Action to build the key, which is done only if the UDM data has changed since the key was built
  // The check is performed by comparing the modified dates of the UDM superfile (sFilename) and the key SF.
  EXPORT #EXPAND( 'aBuildKey_' + %'sAttrNameRx'%) := IF(STD.File.GetLogicalFileAttribute(sFilename(),'modified') > STD.File.GetLogicalFileAttribute(%sKeySF%,'modified'),
                                                        #EXPAND( 'aForceBuildKey_' + %'sAttrNameRx'%),
                                                        STD.System.Log.addWorkunitWarning('Skipping build of ' + %sKeySF% + ' since key was built after last change to the UDM table'));
  
  EXPORT #EXPAND( 'fCreateEmptyKey_' + %'sAttrNameRx'%)(STRING sSuperkey) := FUNCTION
    STRING sEmptyDataName := Common.modSuperfile(sSuperkey + '::empty').fConsolidateSubFileName();
    dEmptyData := DATASET([], RECORDOF(%dOptimized%));
    kEmptyData := INDEX(dEmptyData, {#EXPAND(sAttrNames)}, {dEmptyData}, sEmptyDataName);
    RETURN Common.modKey.macCreateEmptyKey(sSuperkey, sEmptyDataName, dEmptyData, kEmptyData);
  END;
ENDMACRO;
