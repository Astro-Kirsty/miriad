#!/bin/bash

# Miriad shell-script

# Created in ---

# regrid.sh [infile] [temfile]

# regrid infile to have same gridding as temfile 

infile=$1
temfile=$2

head=`basename $1 .fits`
outfile=${head}_regrid.fits


echo
echo Regridding using the input files ${infile} and ${temfile}
echo


fits in=${infile} out=mirout op=xyin
fits in=${temfile} out=mirtemout op=xyin

regrid in=mirout out=regridout tin=mirtemout axes=1,2
fits in=regridout out=${outfile} op=xyout


rm -rf mirout
rm -rf mirtemout
rm -rf regridout

echo
echo Output written to $outfile
echo
