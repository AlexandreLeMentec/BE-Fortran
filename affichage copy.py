#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np

# CHAMP A MODIFIER EN FONCTION DU NOMBRE D'ELEMENTS DES TABLEAUX INDIVIDUELS
nb_elements = 100
t = 899
x = np.zeros(nb_elements)
Cexp = np.zeros(nb_elements)
Ctheo = np.zeros(nb_elements)

line_count = 0
char_count = 0
with open("resultat.dat", "r") as my_file:
  for line in my_file:
    if line_count == 0:
      x = line.split()
    if line_count == 1+2*(t):
      Cexp = line.split()
    if line_count == 2+2*(t):
      Ctheo = line.split()
    line_count += 1

for i in range(nb_elements):
  x[i] = float(x[i])
  Cexp[i] = float(Cexp[i])
  Ctheo[i] = float(Ctheo[i])

plt.plot(x,Cexp,"--b",linewidth=1.0)
plt.plot(x,Ctheo,"--r",linewidth=1.0)
print (Cexp[50])
plt.title("Evolution de C en fonction de x à t = "+str(t*30)+" s")
plt.xlim(0.,1000.)
plt.ylim(0.,1.)
plt.xlabel('x (m)',fontsize=16)
plt.ylabel('concentration',fontsize=16)
plt.savefig("res.png")

print("generation de 1 image finie")
