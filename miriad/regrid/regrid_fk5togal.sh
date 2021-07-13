#!/bin/bash
#Miriad shell script

# regridding from J2000 (Ra & Dec) to Galactic coords (glon and glat)
# regrid_fk5togal.sh [filename]
infile=$1
head=`basename $infile .fits`
outfile=${head}_gal.fits

fits in=${infile} out=miriadout op=xyin
regrid in=miriadout out=regridout options=galeqsw project=car
fits in=regridout out=${outfile} op=xyout


rm -rf miriadout
rm -rf regridout
