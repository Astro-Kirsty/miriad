#!/bin/bash

# Miriad shell-script

# Created in July 2018

# regrid infile using temfile as a template - ie. new file
# will have the same gridding as the template file.

# regrid_12COtoHI.sh [infile] [temfile]

# for Mopra 12CO (33") and SGPS HI (42") data:
# regrid_12COtoHI.sh [12CO data] [HI data]


if [ $# != 2 ]; then
    echo
    echo Incorrect number of arguments given.
    echo
    echo To run correctly:
    echo    regrid_12COtoHI.sh [12CO fits file] [HI fits file]
    echo
    echo   e.g. regrid_12COtoHI.sh mopra_12CO.fits SGPS_HI.fits
    echo
    echo   *We require 2 fits files that are in the same velocity range
    echo   
    exit 1
fi

infile=$1
temfile=$2

rm -Rf miriad.out > /dev/null
rm -Rf regrid.out > /dev/null
rm -Rf miriadtem.out > /dev/null
rm -rf *.def > /dev/null

head=`basename $1 .fits`
outfile=${head}_regrid.fits


echo
echo Regridding the 12CO Mopra data to be the same as the SGPS HI data
echo using the input files ${infile} and ${temfile}
echo


fits in=${infile} op=xyin out=miriad.out
fits in=${temfile} op=xyin out=miriadtem.out

regrid in=miriad.out out=regrid.out tin=miriadtem.out axes=1,2
fits in=regrid.out op=xyout out=$outfile


rm -rf *.def regrid.out miriad.out miriadtem.out

echo
echo Output written to $outfile
echo
