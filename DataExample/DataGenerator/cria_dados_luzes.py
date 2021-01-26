# -*- coding: utf-8 -*-
import csv
import random

numero_registros = 1000
arquivoOutput = '../arquivo-gerado-luzes.csv'
cabecalho = ['marca', 'ano', 'modelo',
             'luzes_painel', 'luz_airbag', 'luz_freio_estacionamento', 'luz_bateria', 'luz_motor', 
             'luz_temperatura_radiador', 'luz_oleo_motor', 'nivel_oleo_adequado', 'luz_freios_abs', 
             'luz_combustivel', 'carro_sem_combustivel', 'luz_revisao_preventiva',
             'problema']

marca_ano_modelo = ['chevrolet', '2018', 'Onix']
m1 = ['chevrolet', '2018', 'Onix',
      0, 0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0,
      0]

m2 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0,
      20]  # Manutenção de Air Bag

m3 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0, 0,
      0, 0, 0, 0,
      0, 0, 0,
      21]  # Problema no Fluido de Freio

m4 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 1, 0,
      0, 0, 0, 0, 
      0, 0, 0,
      4]  # Bateria ruim

m5 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 1,
      0, 0, 0, 0,
      0, 0, 0,
      13]  # Falha na injeção eletrônica

m6 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0,
      1, 0, 0, 0, 
      0, 0, 0,
      2]  # Falha no sistema de refrigeração

m7 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0,
      0, 1, 1, 0, 
      0, 0, 0,
      22]  # Falha no sistema de lubrificação

m8 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0,
      0, 1, 0, 0,
      0, 0, 0,
      23]  # Vazamento de óleo do motor

m8 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0,
      0, 0, 0, 1,
      0, 0, 0,
      24]  # Falha no ABS

m9 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0,
      0, 0, 0, 0,
      1, 1, 0,
      26]  # Combustível do reservatório

m10 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 1,
      27]  # Revisão preventiva

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
