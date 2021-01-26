IMPORT Common, MDL;
EXPORT modLuzes := MODULE
  EXPORT lLayout := RECORD
    MDL.modLayouts.lMeta;
    UNSIGNED1 luzes_painel;
    UNSIGNED1 luz_airbag;
    UNSIGNED1 luz_freio_estacionamento;
    UNSIGNED1 luz_bateria;
    UNSIGNED1 luz_motor;
    UNSIGNED1 luz_temperatura_radiador;
    UNSIGNED1 luz_oleo_motor;
    UNSIGNED1 nivel_oleo_adequado;
    UNSIGNED1 luz_freios_abs;
    UNSIGNED1 luz_combustivel;
    UNSIGNED1 carro_sem_combustivel;
    UNSIGNED1 luz_revisao_preventiva;
    UNSIGNED1 problema;
  END;

  EXPORT lLayoutKey := {lLayout AND NOT [marca, ano, modelo]};

  EXPORT sRawFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sRawSubSystem, 'luzes', LF);
  EXPORT sFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem, 'luzes', LF);
  
  EXPORT dRawData(STRING LF = '') := DATASET(sRawFilename(LF), {lLayout AND NOT rid}, CSV(HEADING(1), SEPARATOR(',')));
  EXPORT dData(STRING LF = '') := DATASET(sFilename(LF), lLayout, THOR);
  EXPORT dMIAData(STRING LF = '') := DATASET(sFilename(LF), lLayoutKey, THOR);

  // Keys
  MDL.macCreateIndex(dMIAData(), 'lLayoutKey', 'rid', 'luzes', '', '');

END;