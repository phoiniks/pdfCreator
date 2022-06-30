#!/usr/bin/zsh

datum=`date`
datum=${datum//[: ]/_}
datum=${datum//./}

typeset -a array

array=($1 $2 $3 $4)

datei=$4"_"$datum".pdf"

array[4]=$datei

for i ("$array[@]") print -r -- "DATEI: "$i

echo
echo "Eingabeparameter: "$#array
echo

if [ $#array != 4 ]; then
    echo
    echo "Es fehlen Eingabeparameter"
    echo
    echo "Der Vollständigkeit halber müssen Sie vier Parameter eingeben:"
    echo "1.    den Namen der Datei mit dem Anschreiben"
    echo "2.    den Namen der Datei mit dem Lebenslauf"
    echo "3.    den Namen der Datei mit den Zeugnissen"
    echo "4.    den Namen der Ausgabedatei"
    echo
    exit 1
fi

pdftk $1 $2 $3 cat output "Original_"$datei

# pdfVerkleinern.sh "Original_"$datei $datei
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile=$datei "Original_"$datei
