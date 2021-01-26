IMPORT Common, MDL;
EXPORT modLiquidos := MODULE
  EXPORT lLayout := RECORD
    MDL.modLayouts.lMeta;
    UNSIGNED1 vazando_liquido;
    UNSIGNED1 liquido_colorido;
    UNSIGNED1 liquido_escuro;
    UNSIGNED1 liquido_incolor_indolor;
    UNSIGNED1 liquido_amarelo;
    UNSIGNED1 liquido_azul;
    UNSIGNED1 liquido_verde;
    UNSIGNED1 liquido_vermelho_rosa;
    UNSIGNED1 liquido_laranja;
    UNSIGNED1 liquido_marrom_claro;
    UNSIGNED1 liquido_marrom_escuro;
    UNSIGNED1 liquido_preto;
    UNSIGNED1 liquido_incolor;
    UNSIGNED1 liquido_inodoro;
    UNSIGNED1 problema;
  END;

  EXPORT lLayoutKey := {lLayout AND NOT [marca, ano, modelo]};

  EXPORT sRawFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sRawSubSystem, 'liquidos', LF);
  EXPORT sFilename(STRING LF = '') := Common.modFunctions.fGetFilename(Common.modConstants.sMecanixSubSystem, 'liquidos', LF);
  
  EXPORT dRawData(STRING LF = '') := DATASET(sRawFilename(LF), {lLayout AND NOT rid}, CSV(HEADING(1), SEPARATOR(',')));
  EXPORT dData(STRING LF = '') := DATASET(sFilename(LF), lLayout, THOR);
  EXPORT dMIAData(STRING LF = '') := DATASET(sFilename(LF), lLayoutKey, THOR);

  // Keys
  MDL.macCreateIndex(dMIAData(), 'lLayoutKey', 'rid', 'liquidos', '', '');

END;