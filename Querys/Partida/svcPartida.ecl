EXPORT svcPartida := MACRO
  IMPORT MDL, Querys;
  
  UNSIGNED1 carro_nao_liga:=0:STORED('carro_nao_liga', FORMAT(SEQUENCE(1)));
  UNSIGNED1 utiliza_botao:=0:STORED('utiliza_botao', FORMAT(SEQUENCE(2)));
  UNSIGNED1 luzes_ignicao:=0:STORED('luzes_ignicao', FORMAT(SEQUENCE(3)));
  UNSIGNED1 troca_recente_combustivel:=0:STORED('troca_recente_combustivel', FORMAT(SEQUENCE(4)));
  UNSIGNED1 barulho_ao_ligar:=0:STORED('barulho_ao_ligar', FORMAT(SEQUENCE(5)));
  UNSIGNED1 motor_girando_lentamente:=0:STORED('motor_girando_lentamente', FORMAT(SEQUENCE(6)));
  UNSIGNED1 motor_girando_normalmente:=0:STORED('motor_girando_normalmente', FORMAT(SEQUENCE(7)));
  UNSIGNED1 utiliza_chave:=0:STORED('utiliza_chave', FORMAT(SEQUENCE(8)));
  UNSIGNED1 chave_gira:=0:STORED('chave_gira', FORMAT(SEQUENCE(9)));
  UNSIGNED1 chave_reserva_funcionando:=0:STORED('chave_reserva_funcionando', FORMAT(SEQUENCE(10)));
  
  dInputData := DATASET([{
        1,
        carro_nao_liga,
        utiliza_botao,
        luzes_ignicao,
        troca_recente_combustivel,
        barulho_ao_ligar,
        motor_girando_lentamente,
        motor_girando_normalmente,
        utiliza_chave,
        chave_gira,
        chave_reserva_funcionando,
        0
    }], MDL.modPartida.lLayoutKey
  );

  OUTPUT(Querys.Partida.fGetRecords(dInputData),NAMED('problema'));
ENDMACRO;