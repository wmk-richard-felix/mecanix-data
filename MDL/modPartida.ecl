IMPORT Common, MDL;
EXPORT modPartida := MODULE
  EXPORT lLayout := RECORD
    MDL.modLayouts.lMeta;
    UNSIGNED1 carro_nao_liga;
    UNSIGNED1 utiliza_botao;
    UNSIGNED1 luzes_ignicao;
    UNSIGNED1 troca_recente_combustivel;
    UNSIGNED1 barulho_ao_ligar;
    UNSIGNED1 motor_girando_lentamente;
    UNSIGNED1 motor_girando_normalmente;
    UNSIGNED1 utiliza_chave;
    UNSIGNED1 chave_gira;
    UNSIGNED1 chave_reserva_funcionando;
    UNSIGNED1 problema;
  END;

  EXPORT lLayoutKey := {lLayout AND NOT [marca, ano, modelo]};

  EXPORT sRawFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sRawSubSystem, 'partida', LF);
  EXPORT sFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem, 'partida', LF);
  
  EXPORT dRawData(STRING LF = '') := DATASET(sRawFilename(LF), {lLayout AND NOT rid}, CSV(HEADING(1), SEPARATOR(',')));
  EXPORT dData(STRING LF = '') := DATASET(sFilename(LF), lLayout, THOR);
  EXPORT dMIAData(STRING LF = '') := DATASET(sFilename(LF), lLayoutKey, THOR);

  // Keys
  MDL.macCreateIndex(dMIAData(), 'lLayoutKey', 'rid', 'partida', '', '');

END;