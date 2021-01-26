EXPORT svcVibracao := MACRO
  IMPORT MDL, Querys;
  
  UNSIGNED1 carro_vibrando:=0:STORED('carro_vibrando', FORMAT(SEQUENCE(1)));
  UNSIGNED1 vibrando_parado_movimento:=0:STORED('vibrando_parado_movimento', FORMAT(SEQUENCE(2)));
  UNSIGNED1 vibrando_movimento:=0:STORED('vibrando_movimento', FORMAT(SEQUENCE(3)));
  UNSIGNED1 vibra_pisar_freio:=0:STORED('vibra_pisar_freio', FORMAT(SEQUENCE(4)));
  UNSIGNED1 vibra_aumenta_maiores_velocidades:=0:STORED('vibra_aumenta_maiores_velocidades', FORMAT(SEQUENCE(5)));
  UNSIGNED1 vibra_velocidades_menones:=0:STORED('vibra_velocidades_menones', FORMAT(SEQUENCE(6)));
  UNSIGNED1 vibra_velocidades_maiores:=0:STORED('vibra_velocidades_maiores', FORMAT(SEQUENCE(7)));
  
  dInputData := DATASET([{
        1,
        carro_vibrando,
        vibrando_parado_movimento,
        vibrando_movimento,
        vibra_pisar_freio,
        vibra_aumenta_maiores_velocidades,
        vibra_velocidades_menones,
        vibra_velocidades_maiores,
        0
    }], MDL.modVibracao.lLayoutKey
  );

  OUTPUT(Querys.Vibracao.fGetRecords(dInputData),NAMED('problema'));
ENDMACRO;