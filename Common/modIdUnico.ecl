IMPORT Common, MDL;

EXPORT modIdUnico(STRING sTabela = '') := MODULE

  SHARED sIdUnicoFilename := Common.modConstants.sIdUnicoFilename + sTabela;
  SHARED lLayout := RECORD
    STRING tabela;
    UNSIGNED id;
  END;

  EXPORT aCreateIDfile := OUTPUT(DATASET([{sTabela, 1}], lLayout),, sIdUnicoFilename, OVERWRITE);

  EXPORT fReturnId := FUNCTION
    dDataId := DATASET(sIdUnicoFilename, lLayout, THOR);
    RETURN (STRING) dDataId[1].id;
  END;

  EXPORT fUpdateId := FUNCTION
    uId := (UNSIGNED) fReturnId;
    RETURN OUTPUT(DATASET([{sTabela, uId+1}], lLayout),, sIdUnicoFilename, OVERWRITE);
  END;

END;