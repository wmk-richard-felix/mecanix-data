IMPORT Common, MDL;

EXPORT modBarulhos := MODULE

  EXPORT lLayout := MDL.modLayouts.lBarulhos;

  EXPORT sRawFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sRawSubSystem, 'problemas', LF);
  EXPORT sFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem, 'problemas', LF);
  
  EXPORT dRawData(STRING LF = '') := DATASET(sRawFilename(LF), {lLayout AND NOT id_unico}, CSV(HEADING(1), SEPARATOR(',')));
  EXPORT dData(STRING LF = '') := DATASET(sFilename(LF), lLayout, THOR);

END;