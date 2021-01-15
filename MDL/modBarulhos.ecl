IMPORT Common, MDL;
EXPORT modBarulhos := MODULE
  EXPORT lLayout := RECORD
    MDL.modLayouts.lMeta;
    STRING barulho_estranho;
    STRING carro_ligado_parado;
    STRING barulho_durante_partida;
    STRING barulho_girando_volante;
    STRING barulho_engate_marcha;
    STRING barulho_ligado_movimento;
    STRING barulho_pisa_freio;
    STRING barulho_rodas;
    STRING barulho_rodas_constantes;
    STRING barulho_rodas_intermitente;
    STRING barulho_lombadas;
    STRING carro_sem_forca;
    STRING barulho_aceleracao;
    STRING motor_girando_lentamente;
    STRING motor_girando_normal;
    STRING problema;
  END;

  EXPORT sRawFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sRawSubSystem, 'barulhos', LF);
  EXPORT sFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem, 'barulhos', LF);
  
  EXPORT dRawData(STRING LF = '') := DATASET(sRawFilename(LF), {lLayout AND NOT id_unico}, CSV(HEADING(1), SEPARATOR(',')));
  EXPORT dData(STRING LF = '') := DATASET(sFilename(LF), lLayout, THOR);

END;