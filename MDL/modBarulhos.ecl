IMPORT Common, MDL;
EXPORT modBarulhos := MODULE
  EXPORT lLayout := RECORD
    MDL.modLayouts.lMeta;
    UNSIGNED1 barulho_estranho;
    UNSIGNED1 carro_ligado_parado;
    UNSIGNED1 barulho_durante_partida;
    UNSIGNED1 barulho_girando_volante;
    UNSIGNED1 barulho_engate_marcha;
    UNSIGNED1 barulho_ligado_movimento;
    UNSIGNED1 barulho_pisa_freio;
    UNSIGNED1 barulho_rodas;
    UNSIGNED1 barulho_rodas_constantes;
    UNSIGNED1 barulho_rodas_intermitente;
    UNSIGNED1 barulho_lombadas;
    UNSIGNED1 carro_sem_forca;
    UNSIGNED1 barulho_aceleracao;
    UNSIGNED1 motor_girando_lentamente;
    UNSIGNED1 motor_girando_normal;
    UNSIGNED1 problema;
  END;

  EXPORT lLayoutKey := {lLayout AND NOT [marca, ano, modelo]};

  EXPORT sRawFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sRawSubSystem, 'barulhos', LF);
  EXPORT sFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem, 'barulhos', LF);
  
  EXPORT dRawData(STRING LF = '') := DATASET(sRawFilename(LF), {lLayout AND NOT rid}, CSV(HEADING(1), SEPARATOR(',')));
  EXPORT dData(STRING LF = '') := DATASET(sFilename(LF), lLayout, THOR);
  EXPORT dMIAData(STRING LF = '') := DATASET(sFilename(LF), lLayoutKey, THOR);

  // Keys
  MDL.macCreateIndex(dMIAData(), 'lLayoutKey', 'rid', 'barulhos', '', '');

END;