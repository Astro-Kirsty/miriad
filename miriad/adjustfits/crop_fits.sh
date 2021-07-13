#!/bin/bash

# Code created July 2018 by Kirsty

# Miriad shell script to crop a large fits file to a smaller one
# Extremely useful for large data sets!!

# to run, go to path where the fits file is:
# crop_fits.sh [fits_infile] [type]

if [ $# != 2 ]; then
    echo
    echo Incorrect number of arguments given.
    echo
    echo To run correctly:
    echo      crop_fits.sh [fits infile] [type]
    echo where type: 1 = HI data,   2 = 12CO or 13CO Mopra data
    echo       type: 3 = Spitzer data, 4 = HOPS data
    echo    e.g. crop_fits 12CO_mopra.fits 2
    echo
    exit 1
fi


infile=$1
type=$2
head=`basename $infile .fits`
outfile=${head}_crop.fits

# boxes(xmin, ymin, xmax, ymax)

if [ $type == 1 ]; then
   echo
   echo Creating cropped file for HI SGPS data
   echo
   fits in=${infile} out=dummymir op=xyin
   fits in=dummymir out=${outfile} region='kms, boxes(454, 82.5, 546, 173.5)' op=xyout
   echo
   echo Output file written to ${outfile}
   echo
fi

   
if [ $type == 2 ]; then
   echo
   echo Creating cropped file for 12CO/13CO Mopra data
   echo
   fits in=${infile} out=dummymir op=xyin
   fits in=dummymir out=${outfile} region='kms, boxes(8.5, 5.5, 127.5, 126.5)' op=xyout
   echo
   echo Output file written to ${outfile}
   echo
fi


if [ $type == 3 ]; then
   echo
   echo Creating cropped file for Spitzer data
   echo
   fits in=${infile} out=dummymir op=xyin
   fits in=dummymir out=${outfile} region='boxes(0, 325, 1400, 1208)' op=xyout
   echo
   echo Output file written to ${outfile}
   echo
fi

if [ $type == 4 ]; then
   echo
   echo Creating cropped file for HOPS data
   echo
   fits in=${infile} out=dummymir op=xyin
   fits in=dummymir out=${outfile} region='boxes(0, 0, 350, 125)' op=xyout
   echo
   echo Output file written to ${outfile}
   echo
fi



rm -rf dummymir
