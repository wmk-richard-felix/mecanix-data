# -*- coding: utf-8 -*-
import csv
import random

numero_registros = 600
arquivoOutput = '../arquivo-gerado-partida.csv'

marca_ano_modelo = ['chevrolet', '2018', 'Onix']
m1 = ['chevrolet', '2018', 'Onix',
      0, 0, 0, 0, 0,
      0, 0, 0, 0, 0,
      0]

m2 = ['chevrolet', '2018', 'Onix',
      1, 1, 1, 0, 0,
      0, 0, 0, 0, 0,
      4]  # Bateria ruim

m3 = ['chevrolet', '2018', 'Onix',
      1, 1, 1, 1, 0,
      0, 0, 0, 0, 0,
      13]  # Falha na injeção eletrônica

m4 = ['chevrolet', '2018', 'Onix',
      1, 1, 1, 0, 1,
      1, 0, 0, 0, 0,
      40]  # Falha no sistema de Ignição

m5 = ['chevrolet', '2018', 'Onix',
      1, 1, 1, 0, 1,
      0, 1, 0, 0, 0,
      41]  # Sensor de Cambota

m6 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0,
      0, 0, 1, 1, 0,
      4]  # Bateria ruim

m7 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 1, 0,
      0, 0, 1, 1, 0,
      13]  # Falha na injeção eletrônica

m8 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0, 1,
      1, 0, 1, 1, 0,
      40]  # Falha no sistema de Ignição

m9 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0, 1,
      0, 1, 1, 1, 0,
      41]  # Sensor de cambota

m10 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0,
      0, 0, 1, 0, 1,
      42]  # Falha na Chave de Ignição

cabecalho = ['marca', 'ano', 'modelo',
             'carro_nao_liga', 'utiliza_botao', 'luzes_ignicao', 'troca_recente_combustivel', 'barulho_ao_ligar',
             'motor_girando_lentamente', 'motor_girando_normalmente', 'utiliza_chave', 'chave_gira', 'chave_reserva_funcionando',
             'problema']

with open(arquivoOutput, 'wb') as csvfile:
    spamwriter = csv.writer(csvfile, delimiter=',', quoting=csv.QUOTE_MINIMAL)
    spamwriter.writerow(cabecalho)
    contador = 0
    while (contador <= numero_registros):
        num_al = random.randint(1, 12)
        if num_al == 1:
            spamwriter.writerow(m1)
        elif num_al == 2:
            spamwriter.writerow(m2)
        elif num_al == 3:
            spamwriter.writerow(m3)
        elif num_al == 4:
            spamwriter.writerow(m4)
        elif num_al == 5:
            spamwriter.writerow(m5)
        elif num_al == 6:
            spamwriter.writerow(m6)
        elif num_al == 7:
            spamwriter.writerow(m7)
        elif num_al == 8:
            spamwriter.writerow(m8)
        elif num_al == 9:
            spamwriter.writerow(m9)
        else:
            spamwriter.writerow(m10)

        contador = contador + 1
