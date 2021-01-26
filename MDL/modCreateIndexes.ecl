IMPORT Common, MDL, STD, ETL;

EXPORT modCreateIndexes := MODULE

  LOCAL aCreateOneIndex( sTableName, sAttrName, bForceBuild = FALSE) := FUNCTIONMACRO
    sCmd := '\n'+
            'IF(NOT STD.File.SuperFileExists(MDL.@@@.sKeySF_%%%),                 \n'+
            '  SEQUENTIAL(                                                        \n'+
            '    Common.modSuperFile(MDL.@@@.sKeySF_%%%).aCreate();               \n'+
            '    MDL.@@@.fCreateEmptyKey_%%%(MDL.@@@.sKeySF_%%%);                 \n'+
            '  )                                                                  \n'+
            ');                                                                   \n'+
            'IF(bForceBuild, MDL.@@@.aForceBuildKey_%%%, MDL.@@@.aBuildKey_%%%)   \n';
  
    sCmdPatched :=       REGEXREPLACE( '@@@', sCmd, sTableName);
    sCmdPatchedResult := REGEXREPLACE( '%%%', sCmdPatched, sAttrName);
  
    RETURN SEQUENTIAL( #EXPAND(sCmdPatchedResult));
  ENDMACRO;

  EXPORT aCreateIndexes(BOOLEAN bForceBuild = FALSE) := ORDERED (
    // MDL File indexes MUST be build first
    aCreateOneIndex('modBarulhos',  'rid', bForceBuild);
    aCreateOneIndex('modFumaca',    'rid', bForceBuild);
    aCreateOneIndex('modLiquidos',  'rid', bForceBuild);
    aCreateOneIndex('modLuzes',     'rid', bForceBuild);
    aCreateOneIndex('modPartida',   'rid', bForceBuild);
    aCreateOneIndex('modVibracao',  'rid', bForceBuild);
  );
END;