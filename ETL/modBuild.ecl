EXPORT modBuild := MODULE

  EXPORT macBuild(sFile = '') := FUNCTIONMACRO
    IMPORT Common, MDL, STD;

    sFilename := #EXPAND('MDL.mod' + sFile + '.sFilename()');
    dData := #EXPAND('MDL.mod' + sFile + '.dRawData()');
    
    dDataOut := PROJECT(dData, TRANSFORM(#EXPAND('MDL.mod' + sFile + '.lLayout'),
      SELF.rid := WHEN((UNSIGNED) (Common.modIdUnico(sFile).fReturnId + (STRING) COUNTER), Common.modIdUnico(sFile).fUpdateId);
      SELF := LEFT; 
    ));
    
    aOutputData := SEQUENTIAL(
      OUTPUT(dDataOut,, sFilename, COMPRESSED, OVERWRITE);
      OUTPUT(#EXPAND('MDL.mod' + sFile + '.dData()'), NAMED('TABELA_CONSTRUIDA_' + sFile));
    );
    
    RETURN aOutputData;

  ENDMACRO;

  EXPORT macBuildWithId(sFile = '') := FUNCTIONMACRO
    IMPORT Common, MDL, STD;

    sFilename := #EXPAND('MDL.mod' + sFile + '.sFilename()');
    dData := #EXPAND('MDL.mod' + sFile + '.dRawData()');
    
    aOutputData := SEQUENTIAL(
      OUTPUT(dData,, sFilename, COMPRESSED, OVERWRITE);
      OUTPUT(#EXPAND('MDL.mod' + sFile + '.dData()'), NAMED('TABELA_CONSTRUIDA'));
    );
    
    RETURN aOutputData;

  ENDMACRO;

END;