#!/bin/bash
#Miriad shell script

# regridding different Galactic coordinates
# from GLON-*** and GLAT-***    to    GLON-CAR and GLAT-CAR  
# regrid_toCAR.sh [filename]

infile=$1
head=`basename $infile .fits`
outfile=${head}_car.fits

fits in=${infile} out=miriadout op=xyin
regrid in=miriadout out=regridout project=car
fits in=regridout out=${outfile} op=xyout


rm -rf miriadout
rm -rf regridout
