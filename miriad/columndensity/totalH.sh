#!/bin/bash

# Code created in Aug 2017 by Kirsty

# Miriad shell script to calculate total hydrogen column density

# totalH.sh [CO fits file] [HI fits file]
# need to be in column density form as well
# both CO and HI file must be of the same km/s range

if [ $# != 2 ]; then
    echo
    echo Incorrect number of arguments given.
    echo
    echo To run correctly:
    echo    totalH.sh [CO fits file] [HI fits file]
    echo
    echo   e.g. totalH.sh mopra_CO.fits SGPS_HI.fits
    echo
    echo   *We require 2 fits files that are in the same velocity range
    echo   
    exit 1
fi


infileCO=$1
infileHI=$2

head=`basename $infileCO .fits`
outfile=${head}_totalNh.fits

echo
echo Making a total column density map for a given velocity range
echo using the input files ${infileCO} and ${infileHI}
echo

fits in=${infileCO} out=dummyCO op=xyin
fits in=${infileHI} out=dummyHI op=xyin
maths exp=2*dummyCO+dummyHI out=dummyout #options=unmask
fits in=dummyout out=${outfile} op=xyout

echo
echo Output file written to ${outfile}
echo

rm -rf dummyCO
rm -rf dummyHI
rm -rf dummyout
