#!/bin/bash
if [ ! -e prog.exe ]
then
        echo "[I] Pas de prog.exe. Exécution de make"
        make
        echo "[I] Make fini."
fi

echo "[I] Exécution de prog.exe."
./prog.exe
echo "[I] prog.exe exécuté."
echo "[I] Génération des images."
python lecture_fichier_n_images.py
cd img
ffmpeg -r 25 -f image2 -s 800x600 -i 1%04d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p output_ffmpeg.mp4
echo "[I] Fini."
