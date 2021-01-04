#!/bin/bash
jaune='\e[1;33m'
neutre='\e[0;m'
if [ ! -e prog.exe ]
then
        echo -e "${jaune}[I] Pas de prog.exe. Exécution de make${neutre}"
        echo "make"
        make
        echo -e "${jaune}[I] Make fini.${neutre}"
fi

echo -e "${jaune}[I] Exécution de prog.exe.${neutre}"
echo "./prog.exe"
./prog.exe
echo -e "${jaune}[I] prog.exe exécuté.${neutre}"
echo -e "${jaune}[I] Génération des images.${neutre}"
echo "python lecture_fichier_n_images.py"
python lecture_fichier_n_images.py
echo "cd img"
cd img
echo "ffmpeg -r 25 -f image2 -s 800x600 -i 1%04d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p output_ffmpeg.mp4"
ffmpeg -r 25 -f image2 -s 800x600 -i 1%04d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p output_ffmpeg.mp4
echo -e "${jaune}[I] Fini.${neutre}"
vlc output_ffmpeg.mp4 2>> /dev/null
