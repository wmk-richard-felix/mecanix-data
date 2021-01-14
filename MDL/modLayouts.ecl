EXPORT modLayouts := MODULE

  EXPORT lMeta := RECORD
    UNSIGNED id_unico;
    STRING marca;
    STRING ano;
    STRING modelo;
  END;

  EXPORT lBarulhos := RECORD
    lMeta;
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
  END;

END;