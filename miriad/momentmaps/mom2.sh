#!/bin/bash

# Code created September 2018 by Kirsty

# Miriad shell-script for the moment 2 task

# Moment 2 maps, ie the velocity dispersion maps
# Fits file assumed as the input

# To run:
#     moment_2.sh [kms1] [kms2] [clip] [fits/miriad cube] [type]



if [ $# != 5 ]; then
    echo
    echo Incorrect number of arguments given.
    echo
    echo To run correctly:
    echo    moment_2.sh [kms1] [kms2] [clip] [fits/miriad cube] [type] 
    echo
    echo Where type=1: no hanning, type=2: hanning smoothing
    echo
    echo   e.g. moment_2.sh.sh 12 24 1.5 mopra_CO.fits 1
    echo
    exit 1
fi

kms1=$1
kms2=$2
clip=$3
infile=$4
type=$5

echo
echo Moment 2 map of ${infile}
echo from ${kms1} to ${kms2} km/s
echo

head=`basename $infile .fits`
outfile=${head}_mom2_${kms1}_${kms2}_${clip}K.fits

if [ $type == 1 ]; then
    kms1=$1
    kms2=$2
    clip=$3
    fits in=${infile} out=dummyin op=xyin
    moment in=dummyin region="kms,images(${kms1},${kms2})" out=dummyout mom=2 axis=3 clip=${clip}
    fits in=dummyout op=xyout out=${outfile}
    echo
    echo File written to ${outfile} 
    echo
    echo clipping pixels below ${clip} K
    echo
fi


if [ $type == 2 ]; then
    kms1=$1
    kms2=$2
    clip=$3
    fits in=${infile} out=dummyin op=xyin
    moment in=dummyin region="kms,images(${kms1},${kms2})" out=dummyout mom=2 axis=3 clip=${clip}
    hanning in=dummyout width=5 out=dummyout2
    fits in=dummyout2 op=xyout out=${outfile}
    echo
    echo File written to ${outfile} 
    echo
    echo clipping pixels below ${clip} K
    echo
    echo Hanning smoothing with width = 5 pixels
    echo
fi

rm -rf dummyin
rm -rf dummyout
rm -rf dummyout2
