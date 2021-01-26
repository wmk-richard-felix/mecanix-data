# -*- coding: utf-8 -*-
import csv
import random

numero_registros = 600
arquivoOutput = '../arquivo-gerado-liquidos.csv'

m1 = ['chevrolet', '2018', 'Onix',
      0, 0, 0, 0, 0,
      0, 0, 0, 0, 0,
      0, 0, 0, 0,
      0]

m2 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 0, 1,
      0, 0, 0, 0, 0,
      0, 0, 0, 0,
      34]  # Vazamento do líquido do radiador ou fluído de freio

m3 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 0, 0,
      1, 0, 0, 0, 0,
      0, 0, 0, 0,
      34]  # Vazamento do líquido do radiador ou fluído de freio

m4 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 0, 0,
      34]  # Vazamento do líquido do radiador ou fluído de freio

m5 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 0,
      34]  # Vazamento do líquido do radiador ou fluído de freio

m6 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 0, 0,
      0, 0, 0, 1, 0,
      0, 0, 0, 0,
      34]  # Vazamento do líquido do radiador ou fluído de freio

m7 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0, 0,
      0, 0, 0, 0, 1,
      0, 0, 0, 0,
      35]  # Vazamento do líquido da transmissão ou direção hidráulica

m8 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0, 0,
      0, 0, 0, 0, 0,
      1, 0, 0, 0,
      36]  # Vazamento do fluido de freio ou óleo do motor


m9 = ['chevrolet', '2018', 'Onix',
      1, 0, 1, 0, 0,
      0, 0, 0, 0, 0,
      0, 1, 0, 0,
      37]  # Vazamento de óleo do motor


m10 = ['chevrolet', '2018', 'Onix',
       1, 0, 0, 1, 0,
       0, 0, 0, 0, 0,
       0, 0, 1, 0,
       38]  # Vazamento de Combustível

m11 = ['chevrolet', '2018', 'Onix',
       1, 0, 0, 1, 0,
       0, 0, 0, 0, 0,
       0, 0, 0, 1,
       39] # Vazamento de água

cabecalho = ['marca', 'ano', 'modelo',
             'vazando_liquido', 'liquido_colorido', 'liquido_escuro', 'liquido_incolor_indolor', 'liquido_amarelo',
             'liquido_azul', 'liquido_verde', 'liquido_vermelho_rosa', 'liquido_laranja', 'liquido_marrom_claro',
             'liquido_marrom_escuro', 'liquido_preto', 'liquido_incolor', 'liquido_inodoro',
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
        elif num_al == 10:
            spamwriter.writerow(m10)
        else:
            spamwriter.writerow(m8)

        contador = contador + 1
