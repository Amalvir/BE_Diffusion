#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np
import os

# CHAMP A MODIFIER EN FONCTION DU NOMBRE D'ELEMENTS DES TABLEAUX INDIVIDUELS
nb_elements = 30

# creation d'un dossier qui contiendra les images generees
os.system("mkdir -p img/")

x = np.zeros(nb_elements)
y = np.zeros(nb_elements)
line_count = 0
j  = 0
with open("res.csv", "r") as my_file:
  for line in my_file:
    str = line.split()
    line_count += 1
    x[line_count-1]=str[0]
    y[line_count-1]=str[1]
    if line_count == nb_elements:
      line_count = 0
      j += 1
      plt.title("Evolution")
      plt.xlim(0.,1000.)
      plt.ylim(0.,1.)
      plt.xlabel('x (m)',fontsize=16)
      plt.ylabel('concentration',fontsize=16)
      plt.plot(x,y,"--bo",linewidth=1.0)
      # sauvegarde de l'image
      plt.savefig("img/"+repr(10000+j)+".png")
      plt.close()

print("generation images fini")

# pour creer la video sous linux a partir des images avec mencoder
# mencoder mf://\*.png -mf w=800:h=600:fps=6:type=png -ovc lavc -lavcopts vcodec=mpeg4 -oac copy -o output.avi

# pour creer la video sous linux a partir des images avec ffmpeg
#ffmpeg -r 6 -f image2 -s 800x600 -i 1%04d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p output_ffmpeg.mp4

