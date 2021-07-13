#!/bin/bash

# Miriad shell-script

# Created in November 2018

# regrid infile using temfile as a template - ie. new file
# will have the same gridding as the template file.

# regrid_COtoHESS.sh [infile] [temfile]

# for Mopra 12CO (~30") and HESS (~70") data:
# regrid_COtoHESS.sh [12CO data] [HESS data]


if [ $# != 2 ]; then
    echo
    echo Incorrect number of arguments given.
    echo
    echo To run correctly:
    echo    regrid_COtoHESS.sh [12CO fits file] [HESS fits file]
    echo
    echo   e.g. regrid_COtoHESS.sh mopra_12CO.fits HESS_data.fits
    echo   
    exit 1
fi

infile=$1
temfile=$2

head=`basename $1 .fits`
outfile=${head}_regrid.fits


echo
echo Regridding the 12CO mopra data to be the same as the HESS data
echo using the input files ${infile} and ${temfile}
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
