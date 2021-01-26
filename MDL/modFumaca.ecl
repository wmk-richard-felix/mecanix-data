IMPORT Common, MDL;
EXPORT modFumaca := MODULE
  EXPORT lLayout := RECORD
    MDL.modLayouts.lMeta;
    UNSIGNED1 saindo_fumaca;
    UNSIGNED1 fumaca_capo;
    UNSIGNED1 fumaca_roda;
    UNSIGNED1 fumaca_ecapamento;
    UNSIGNED1 terreno_motanhoso;
    UNSIGNED1 freio_de_mao_etava_acionado;
    UNSIGNED1 fumaca_branca;
    UNSIGNED1 fumaca_preta;
    UNSIGNED1 fumaca_azulada;
    UNSIGNED1 problema;
  END;

  EXPORT lLayoutKey := {lLayout AND NOT [marca, ano, modelo]};

  EXPORT sRawFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sRawSubSystem, 'fumaca', LF);
  EXPORT sFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem, 'fumaca', LF);
  
  EXPORT dRawData(STRING LF = '') := DATASET(sRawFilename(LF), {lLayout AND NOT rid}, CSV(HEADING(1), SEPARATOR(',')));
  EXPORT dData(STRING LF = '') := DATASET(sFilename(LF), lLayout, THOR);
  EXPORT dMIAData(STRING LF = '') := DATASET(sFilename(LF), lLayoutKey, THOR);

  // Keys
  MDL.macCreateIndex(dMIAData(), 'lLayoutKey', 'rid', 'fumaca', '', '');

END;