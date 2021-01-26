IMPORT Common, MDL;

EXPORT modIdUnico(STRING sTabela = '') := MODULE

  SHARED fIdUnicoFilename(STRING sTabela = '') := FUNCTION
    RETURN Common.modConstants.sIdUnicoFilename + sTabela;
  END;

  SHARED lLayout := RECORD
    STRING tabela;
    UNSIGNED id;
  END;

  EXPORT aCreateIDfile(STRING sTabela = '') := OUTPUT(DATASET([{sTabela, 1}], lLayout),, fIdUnicoFilename(sTabela), OVERWRITE);

  EXPORT fReturnId := FUNCTION
    dDataId := DATASET(fIdUnicoFilename(sTabela), lLayout, THOR);
    RETURN (STRING) dDataId[1].id;
  END;

  EXPORT fUpdateId := FUNCTION
    uId := (UNSIGNED) fReturnId;
    RETURN OUTPUT(DATASET([{sTabela, uId+1}], lLayout),, fIdUnicoFilename(sTabela), OVERWRITE);
  END;

END;