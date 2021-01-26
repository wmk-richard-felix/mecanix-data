IMPORT Common, MDL;
EXPORT modVibracao := MODULE
  EXPORT lLayout := RECORD
    MDL.modLayouts.lMeta;
    UNSIGNED1 carro_vibrando;
    UNSIGNED1 vibrando_parado_movimento;
    UNSIGNED1 vibrando_movimento;
    UNSIGNED1 vibra_pisar_freio;
    UNSIGNED1 vibra_aumenta_maiores_velocidades;
    UNSIGNED1 vibra_velocidades_menones;
    UNSIGNED1 vibra_velocidades_maiores;
    UNSIGNED1 problema
  END;

  EXPORT lLayoutKey := {lLayout AND NOT [marca, ano, modelo]};

  EXPORT sRawFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sRawSubSystem, 'vibracao', LF);
  EXPORT sFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem, 'vibracao', LF);
  
  EXPORT dRawData(STRING LF = '') := DATASET(sRawFilename(LF), {lLayout AND NOT rid}, CSV(HEADING(1), SEPARATOR(',')));
  EXPORT dData(STRING LF = '') := DATASET(sFilename(LF), lLayout, THOR);
  EXPORT dMIAData(STRING LF = '') := DATASET(sFilename(LF), lLayoutKey, THOR);

  // Keys
  MDL.macCreateIndex(dMIAData(), 'lLayoutKey', 'rid', 'vibracao', '', '');

END;