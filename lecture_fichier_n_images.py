#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np
import os
import math as m

# CHAMP A MODIFIER EN FONCTION DU NOMBRE D'ELEMENTS DES TABLEAUX INDIVIDUELS

don = np.loadtxt("donnee.dat",comments='!')

#0 !C0
#1 !L
#2 !D
#3 !xd
#4 !xf
#5 !N
#6 !Nt
#7!tf

nb_elements = int(don[5])
# creation d'un dossier qui contiendra les images generees
os.system("mkdir -p img/")
os.system("rm -f img/*")

res = np.loadtxt("res.csv")

if res[0,1]>1e-8:
# Cas de l'étape ou on trace des trucs en logs
  plt.xscale('log')
  plt.yscale('log')
  delta_t = don[7]/don[6]
  plt.title(f"Evolution en échelle log de la moyenne de l'erreur\n avec $\Delta t = {delta_t}$ et $D={don[2]}~m^2/s$")
  #plt.xlabel(r'$\Delta t/T_f$')
  plt.xlabel(r'$R$')
  plt.ylabel('Erreur')

  p = np.polyfit(np.log(res[:,0]),np.log(res[:,1]),1)

  tau = p[0]
  k = m.exp(p[1])
  
  plt.plot(res[:,0],k*pow(res[:,0],tau),"-r",label=str(tau)+"x + "+str(k))
  for k in range(res.shape[1]-1):
    plt.plot(res[:,0],res[:,k+1],"--o",linewidth=1.0)
  plt.legend()
  # sauvegarde de l'image
  plt.savefig("img/"+repr(10000)+".png")
  plt.close()
else:
  j = 0
  i = 0
  delta_t = don[7]/(don[6]-1)
  t = 0.
  while i < res.shape[0]:
    j += 1
    plt.title(f"Évolution de la concentration dans l'espace\n avec $C_0={don[0]}~mol/L$ et $D={don[2]}~m^2/s$ à $t={round(t)}~s$")
    plt.xlim(0.,1000.)
    plt.ylim(0.,1.)
    plt.xlabel(u'x ($m$)')
    plt.ylabel(u'Concentration ($mol/L$)')
    for k in range(res.shape[1]-1):
      plt.plot(res[i:i+nb_elements,0],res[i:i+nb_elements,k+1],"--o",linewidth=1.0)
    # sauvegarde de l'image
    plt.savefig("img/"+repr(10000+j)+".png")
    plt.close()
    i += nb_elements
    t += delta_t

print("generation images finie")

# pour creer la video sous linux a partir des images avec mencoder
# mencoder mf://\*.png -mf w=800:h=600:fps=6:type=png -ovc lavc -lavcopts vcodec=mpeg4 -oac copy -o output.avi

# pour creer la video sous linux a partir des images avec ffmpeg
#ffmpeg -r 6 -f image2 -s 800x600 -i 1%04d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p output_ffmpeg.mp4

