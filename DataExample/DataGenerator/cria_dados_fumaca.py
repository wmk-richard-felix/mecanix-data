# -*- coding: utf-8 -*-
import csv
import random

numero_registros = 1000
arquivoOutput = '../arquivo-gerado-fumaca.csv'
cabecalho = ['marca', 'ano', 'modelo',
             'saindo_fumaca', 'fumaca_capo', 'fumaca_roda', 'fumaca_ecapamento', 'terreno_motanhoso', 
             'freio_de_mao_etava_acionado', 'fumaca_branca', 'fumaca_preta', 'fumaca_azulada',
             'problema']

marca_ano_modelo = ['chevrolet', '2018', 'Onix']
m1 = ['chevrolet', '2018', 'Onix',
      0, 0, 0, 0, 0,
      0, 0, 0, 0,
      0]

m2 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 0, 0,
      0, 1, 0, 0,
      28] # Falha no sistema de arrefecimento

m3 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 0, 0,
      0, 0, 1, 0,
      29] # Falha no motor

m4 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0, 1,
      0, 0, 0, 0,
      30]  # Aquecimento do freio

m5 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0, 0,
      1, 0, 0, 0,
      30]  # Aquecimento do freio


m6 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 1, 0,
      0, 1, 0, 0,
      29]  # Falha no motor

m7 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 1, 0,
      0, 0, 1, 0,
      32] # Falha na queima de combustível

m8 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 1, 0,
      0, 0, 0, 1,
      33]  # Revisão urgente do motor

m9 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0, 0,
      0, 0, 0, 0,
      31]  # Excesso de atrito nos freios

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
        else:
            spamwriter.writerow(m9)

        contador = contador + 1
