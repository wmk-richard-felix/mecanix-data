EXPORT svcFumaca := MACRO
  IMPORT MDL, Querys;
  
  UNSIGNED1 saindo_fumaca:=0:STORED('saindo_fumaca', FORMAT(SEQUENCE(1)));
  UNSIGNED1 fumaca_capo:=0:STORED('fumaca_capo', FORMAT(SEQUENCE(2)));
  UNSIGNED1 fumaca_roda:=0:STORED('fumaca_roda', FORMAT(SEQUENCE(3)));
  UNSIGNED1 fumaca_ecapamento:=0:STORED('fumaca_ecapamento', FORMAT(SEQUENCE(4)));
  UNSIGNED1 terreno_motanhoso:=0:STORED('terreno_motanhoso', FORMAT(SEQUENCE(5)));
  UNSIGNED1 freio_de_mao_etava_acionado:=0:STORED('freio_de_mao_etava_acionado', FORMAT(SEQUENCE(6)));
  UNSIGNED1 fumaca_branca:=0:STORED('fumaca_branca', FORMAT(SEQUENCE(7)));
  UNSIGNED1 fumaca_preta:=0:STORED('fumaca_preta', FORMAT(SEQUENCE(8)));
  UNSIGNED1 fumaca_azulada:=0:STORED('fumaca_azulada', FORMAT(SEQUENCE(9)));

  dInputData := DATASET([{
        1,
        saindo_fumaca,
        fumaca_capo,
        fumaca_roda,
        fumaca_ecapamento,
        terreno_motanhoso,
        freio_de_mao_etava_acionado,
        fumaca_branca,
        fumaca_preta,
        fumaca_azulada,
        0
    }], MDL.modFumaca.lLayoutKey
  );

  OUTPUT(Querys.Fumaca.fGetRecords(dInputData),NAMED('problema'));
ENDMACRO;