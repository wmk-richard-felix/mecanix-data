IMPORT Common, MDL;

EXPORT modProblemas := MODULE

  EXPORT lLayout := RECORD
    UNSIGNED rid;
    STRING descricao;
  END;

  EXPORT sRawFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sRawSubSystem, 'problemas', LF);
  EXPORT sFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem, 'problemas', LF);
  
  EXPORT dRawData(STRING LF = '') := DATASET(sRawFilename(LF), lLayout, CSV(HEADING(1), SEPARATOR(',')));
  EXPORT dData(STRING LF = '') := DATASET(sFilename(LF), lLayout, THOR);

END;