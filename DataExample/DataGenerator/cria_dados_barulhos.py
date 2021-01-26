import csv
import random

numero_registros = 1000
arquivoOutput = '../arquivo-gerado-barulhos.csv'
cabecalho = ['marca', 'ano', 'modelo',
             'barulho_estranho', 'carro_ligado_parado', 'barulho_durante_partida', 'barulho_girando_volante', 'barulho_engate_marcha', 'barulho_ligado_movimento', 'barulho_pisa_freio',
             'barulho_rodas', 'barulho_rodas_constantes', 'barulho_rodas_intermitente', 'barulho_lombadas', 'carro_sem_forca', 'barulho_aceleracao', 'motor_girando_lentamente', 'motor_girando_normal',
             'problema']

marca_ano_modelo = ['chevrolet', '2018', 'Onix']
m1 = ['chevrolet', '2018', 'Onix',
      0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      0]

m2 = ['chevrolet', '2018', 'Onix',
      1, 1, 1, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 1, 0,
      4]  # Bateria Ruim

m3 = ['chevrolet', '2018', 'Onix',
      1, 1, 1, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 1,
      13]  # Injecao eletronica

m4 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 1, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      15]  # Problemas na direcao

m5 = ['chevrolet', '2018', 'Onix',
      1, 1, 0, 0, 1, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      5]  # Problemas no cambio

m6 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0, 1, 1,
      0, 0, 0, 0, 0, 0, 0, 0,
      1]  # Pastilhas de freio

m7 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0, 1, 0,
      1, 1, 0, 0, 0, 0, 0, 0,
      16]  # Alinhamento e balanceamento

m8 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0, 1, 0,
      1, 0, 1, 1, 0, 0, 0, 0,
      3]  # Falha nos amortecedores

m9 = ['chevrolet', '2018', 'Onix',
      1, 0, 0, 0, 0, 1, 0,
      1, 0, 1, 0, 0, 0, 0, 0,
      16]  # Alinhamento e balanceamento

m10 = ['chevrolet', '2018', 'Onix',
       1, 0, 0, 0, 0, 1, 0,
       0, 0, 0, 0, 1, 0, 0, 0,
       12]  # Velas e cabos

m11 = ['chevrolet', '2018', 'Onix',
       1, 0, 0, 0, 0, 1, 0,
       0, 0, 0, 0, 0, 1, 0, 0,
       10]  # Correia dentada com muito uso

m12 = ['chevrolet', '2018', 'Onix',
       1, 0, 0, 0, 1, 1, 0,
       0, 0, 0, 0, 0, 0, 0, 0,
       10]  # Correia dentada com muito uso


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
      elif num_al == 11:
        spamwriter.writerow(m11)
      else:
        spamwriter.writerow(m12)

      contador = contador + 1
