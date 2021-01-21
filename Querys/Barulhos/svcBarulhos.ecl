EXPORT svcBarulhos := MACRO
  IMPORT MDL, Querys;
/*--INFO-- Simple Service Example
<p>Search for a person based on last name</p>
  */
  UNSIGNED1 barulho_estranho:=0:STORED('barulho_estranho');
  UNSIGNED1 carro_ligado_parado:=0:STORED('carro_ligado_parado');
  UNSIGNED1 barulho_durante_partida:=0:STORED('barulho_durante_partida');
  UNSIGNED1 barulho_girando_volante:=0:STORED('barulho_girando_volante');
  UNSIGNED1 barulho_engate_marcha:=0:STORED('barulho_engate_marcha');
  UNSIGNED1 barulho_ligado_movimento:=0:STORED('barulho_ligado_movimento');
  UNSIGNED1 barulho_pisa_freio:=0:STORED('barulho_pisa_freio');
  UNSIGNED1 barulho_rodas:=0:STORED('barulho_rodas');
  UNSIGNED1 barulho_rodas_constantes:=0:STORED('barulho_rodas_constantes');
  UNSIGNED1 barulho_rodas_intermitente:=0:STORED('barulho_rodas_intermitente');
  UNSIGNED1 barulho_lombadas:=0:STORED('barulho_lombadas');
  UNSIGNED1 carro_sem_forca:=0:STORED('carro_sem_forca');
  UNSIGNED1 barulho_aceleracao:=0:STORED('barulho_aceleracao');
  UNSIGNED1 motor_girando_lentamente:=0:STORED('motor_girando_lentamente');
  UNSIGNED1 motor_girando_normal:=0:STORED('motor_girando_normal');

  dInputData := DATASET([{
        1,
        Barulho_estranho,
        carro_ligado_parado,
        barulho_durante_partida,
        barulho_girando_volante,
        barulho_engate_marcha,
        barulho_ligado_movimento,
        barulho_pisa_freio,
        barulho_rodas,
        barulho_rodas_constantes,
        barulho_rodas_intermitente,
        barulho_lombadas,
        carro_sem_forca,
        barulho_aceleracao,
        motor_girando_lentamente,
        motor_girando_normal,
        0
    }], MDL.modBarulhos.lLayoutKey
  );

  OUTPUT(Querys.Barulhos.fGetRecords(dInputData),NAMED('problema'));
ENDMACRO;