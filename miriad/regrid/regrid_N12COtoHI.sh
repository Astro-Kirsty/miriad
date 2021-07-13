#!/bin/bash

# Miriad shell-script

# regrid infile using temfile as a template - ie. new file
# will have the same gridding as the template file.

# regrid.sh [infile] [temfile]

# for Nanten 12CO (~156" or 2.6') and SGPS HI (42") data:
# regrid.sh [HI data] [CO data]




infile=$1
temfile=$2

rm -Rf miriad.out > /dev/null
rm -Rf regrid.out > /dev/null
rm -Rf miriadtem.out > /dev/null
rm -rf *.def > /dev/null

head=`basename $1 .fits`
outfile=${head}_regrid.fits

fits in=${infile} op=xyin out=miriad.out
fits in=${temfile} op=xyin out=miriadtem.out

regrid in=miriad.out out=regrid.out tin=miriadtem.out axes=1,2
fits in=regrid.out op=xyout out=$outfile


rm -rf *.def regrid.out miriad.out miriadtem.out

echo Output written to $outfile

