EXPORT svcLuzes := MACRO
  IMPORT MDL, Querys;
  
  UNSIGNED1 luzes_painel:=0:STORED('luzes_painel', FORMAT(SEQUENCE(1)));
  UNSIGNED1 luz_airbag:=0:STORED('luz_airbag', FORMAT(SEQUENCE(2)));
  UNSIGNED1 luz_freio_estacionamento:=0:STORED('luz_freio_estacionamento', FORMAT(SEQUENCE(3)));
  UNSIGNED1 luz_bateria:=0:STORED('luz_bateria', FORMAT(SEQUENCE(4)));
  UNSIGNED1 luz_motor:=0:STORED('luz_motor', FORMAT(SEQUENCE(5)));
  UNSIGNED1 luz_temperatura_radiador:=0:STORED('luz_temperatura_radiador', FORMAT(SEQUENCE(6)));
  UNSIGNED1 luz_oleo_motor:=0:STORED('luz_oleo_motor', FORMAT(SEQUENCE(7)));
  UNSIGNED1 nivel_oleo_adequado:=0:STORED('nivel_oleo_adequado', FORMAT(SEQUENCE(8)));
  UNSIGNED1 luz_freios_abs:=0:STORED('luz_freios_abs', FORMAT(SEQUENCE(9)));
  UNSIGNED1 luz_combustivel:=0:STORED('luz_combustivel', FORMAT(SEQUENCE(10)));
  UNSIGNED1 carro_sem_combustivel:=0:STORED('carro_sem_combustivel', FORMAT(SEQUENCE(11)));
  UNSIGNED1 luz_revisao_preventiva:=0:STORED('luz_revisao_preventiva', FORMAT(SEQUENCE(12)));

  dInputData := DATASET([{
        1,
        luzes_painel,
        luz_airbag,
        luz_freio_estacionamento,
        luz_bateria,
        luz_motor,
        luz_temperatura_radiador,
        luz_oleo_motor,
        nivel_oleo_adequado,
        luz_freios_abs,
        luz_combustivel,
        carro_sem_combustivel,
        luz_revisao_preventiva,
        0
    }], MDL.modLuzes.lLayoutKey
  );

  OUTPUT(Querys.Luzes.fGetRecords(dInputData),NAMED('problema'));
ENDMACRO;