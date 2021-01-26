# -*- coding: utf-8 -*-
import csv
import random

numero_registros = 1000
arquivoOutput = '../arquivo-gerado-vibrando.csv'

marca_ano_modelo = ['chevrolet', '2018', 'Onix']
m1 = ['chevrolet', '2018', 'Onix',
      0, 0, 0, 0,
      0, 0, 0,
      0]

m2 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 0,
      0, 0, 0,
      29]  # Falha no motor

m3 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 1,
      0, 0, 0,
      3]  # Falha nos amortecedores

m4 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0,
      1, 0, 0,
      16]  # Alinhamento e balanceamento

m5 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0,
      0, 1, 0,
      43]  # Falha nas Articulações e transmissão

m5 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0,
      0, 0, 1,
      3]  # Falha nos amortecedores


cabecalho = ['marca', 'ano', 'modelo',
             'carro_vibrando', 'vibrando_parado_movimento', 'vibrando_movimento', 'vibra_pisar_freio', 
             'vibra_aumenta_maiores_velocidades', 'vibra_velocidades_menones', 'vibra_velocidades_maiores',
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
        else:
            spamwriter.writerow(m5)

        contador = contador + 1
