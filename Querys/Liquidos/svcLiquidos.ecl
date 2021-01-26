EXPORT svcLiquidos := MACRO
  IMPORT MDL, Querys;
  
  UNSIGNED1 vazando_liquido:=0:STORED('vazando_liquido', FORMAT(SEQUENCE(1)));
  UNSIGNED1 liquido_colorido:=0:STORED('liquido_colorido', FORMAT(SEQUENCE(2)));
  UNSIGNED1 liquido_escuro:=0:STORED('liquido_escuro', FORMAT(SEQUENCE(3)));
  UNSIGNED1 liquido_incolor_indolor:=0:STORED('liquido_incolor_indolor', FORMAT(SEQUENCE(4)));
  UNSIGNED1 liquido_amarelo:=0:STORED('liquido_amarelo', FORMAT(SEQUENCE(5)));
  UNSIGNED1 liquido_azul:=0:STORED('liquido_azul', FORMAT(SEQUENCE(6)));
  UNSIGNED1 liquido_verde:=0:STORED('liquido_verde', FORMAT(SEQUENCE(7)));
  UNSIGNED1 liquido_vermelho_rosa:=0:STORED('liquido_vermelho_rosa', FORMAT(SEQUENCE(8)));
  UNSIGNED1 liquido_laranja:=0:STORED('liquido_laranja', FORMAT(SEQUENCE(9)));
  UNSIGNED1 liquido_marrom_claro:=0:STORED('liquido_marrom_claro', FORMAT(SEQUENCE(10)));
  UNSIGNED1 liquido_marrom_escuro:=0:STORED('liquido_marrom_escuro', FORMAT(SEQUENCE(11)));
  UNSIGNED1 liquido_preto:=0:STORED('liquido_preto', FORMAT(SEQUENCE(12)));
  UNSIGNED1 liquido_incolor:=0:STORED('liquido_incolor', FORMAT(SEQUENCE(13)));
  UNSIGNED1 liquido_inodoro:=0:STORED('liquido_inodoro', FORMAT(SEQUENCE(14)));

  dInputData := DATASET([{
        1,
        vazando_liquido,
        liquido_colorido,
        liquido_escuro,
        liquido_incolor_indolor,
        liquido_amarelo,
        liquido_azul,
        liquido_verde,
        liquido_vermelho_rosa,
        liquido_laranja,
        liquido_marrom_claro,
        liquido_marrom_escuro,
        liquido_preto,
        liquido_incolor,
        liquido_inodoro,
        0
    }], MDL.modLiquidos.lLayoutKey
  );

  OUTPUT(Querys.Liquidos.fGetRecords(dInputData),NAMED('problema'));
ENDMACRO;