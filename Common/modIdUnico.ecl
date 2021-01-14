IMPORT Common, MDL;

EXPORT modIdUnico := MODULE

  SHARED sIdUnicoFilename := Common.modConstants.sIdUnicoFilename;

  EXPORT aCreateIDfile := OUTPUT(DATASET([{1}], {UNSIGNED id}),, sIdUnicoFilename);

END;