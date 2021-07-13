#!/bin/bash

# Code created September 2018 by Kirsty

# Miriad shell-script for the moment 0 task

# Moment 0 maps, ie for the integrated velocity regions
# Fits file assumed as the input

# Can use this for PV plots
# where y axis has been swapped with z using PVplots.sh

# To run:
#      mom0.sh [kms1] [kms2] [fits file] [type]


kms1=$1
kms2=$2
infile=$3
type=$4
clip=$5

echo
echo Moment 0 map of ${infile}
echo from ${kms1} to ${kms2} km/s

head=`basename $infile .fits`
outfile=${head}_mom0_${kms1}_${kms2}.fits

# Use this for the Nanten data and for PV plots
if [ $type == 1 ]; then
    kms1=$1
    kms2=$2
    echo
    echo Creating file for Nanten or PV plot
    echo
    fits in=${infile} out=dummyin op=xyin
    moment in=dummyin region="images(${kms1},${kms2})" out=dummyout mom=0 axis=3
    fits in=dummyout op=xyout out=$outfile
    echo
    echo File written to ${outfile}
    echo
fi

# Use this for the Mopra and SGPS data
if [ $type == 2 ]; then
    kms1=$1
    kms2=$2
    clip=$5
    echo
    echo Creating file for Mopra or SGPS
    echo
    echo File written to ${outfile}
    fits in=${infile} out=dummyin op=xyin
    moment in=dummyin region="kms,images(${kms1},${kms2})" clip=${clip} out=dummyout mom=0 axis=3
    fits in=dummyout op=xyout out=$outfile
fi


rm -rf dummyin
rm -rf dummyout
