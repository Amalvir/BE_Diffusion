#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np
import os

# CHAMP A MODIFIER EN FONCTION DU NOMBRE D'ELEMENTS DES TABLEAUX INDIVIDUELS
with open("donnee.dat", "r") as donnee:
  for i in range(5):
    donnee.readline()
  nb_elements = int(donnee.readline().split()[0])

# creation d'un dossier qui contiendra les images generees
os.system("mkdir -p img/")
os.system("rm -f img/*")

res = np.loadtxt("res.csv")

if res[0,1]>1e-8:
  plt.xscale('log')
  plt.yscale('log')
  plt.title("Evolution")
  plt.xlabel(r'$\Delta x/L$',fontsize=16)
  plt.ylabel('Théorique-pratique',fontsize=16)
  plt.plot(res[0:nb_elements,0],res[0:nb_elements,1],"--o",linewidth=1.0)
  plt.plot(res[0:nb_elements,0],res[0:nb_elements,2],"--o",linewidth=1.0)
  # sauvegarde de l'image
  plt.savefig("img/"+repr(10000)+".png")
  plt.close()
else:
  j = 0
  i = 0
  while i < res.shape[0]:
    j += 1
    plt.title("Evolution")
    plt.xlim(0.,1000.)
    plt.ylim(0.,1.)
    plt.xlabel('x (m)',fontsize=16)
    plt.ylabel('concentration',fontsize=16)
    for k in range(res.shape[1]-1):
      plt.plot(res[i:i+nb_elements,0],res[i:i+nb_elements,k+1],"--o",linewidth=1.0)
    # sauvegarde de l'image
    plt.savefig("img/"+repr(10000+j)+".png")
    plt.close()
    i += nb_elements

print("generation images fini")

# pour creer la video sous linux a partir des images avec mencoder
# mencoder mf://\*.png -mf w=800:h=600:fps=6:type=png -ovc lavc -lavcopts vcodec=mpeg4 -oac copy -o output.avi

# pour creer la video sous linux a partir des images avec ffmpeg
#ffmpeg -r 6 -f image2 -s 800x600 -i 1%04d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p output_ffmpeg.mp4

