#!/bin/bash
if [ ! -e prog.exe ]
then
        make
fi

./prog.exe
python lecture_fichier_n_images.py
cd img
ffmpeg -r 6 -f image2 -s 800x600 -i 1%04d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p output_ffmpeg.mp4
