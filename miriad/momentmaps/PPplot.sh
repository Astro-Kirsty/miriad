#!/bin/bash

# Code created August 2018 by Kirsty

# Miriad shell-script for the moment -2 task

# Moment -2 maps, ie for the Peak Pixel Maps
# Fits file (cube) assumed as the input

# To run:
#      PPplot.sh [fits file]


infile=$1
head=`basename $infile .fits`
outfile=${head}_mom-2.fits

fits in=${infile} out=dummyin op=xyin
#moment in=dummyin region="images(0)" out=dummyout mom=-2 axis=3
moment in=dummyin region='kms,images(-50,+180)' out=dummyout mom=-2 axis=3

#Uncleaned 7mm data range
#moment in=dummyin region='kms,images(-40,+140)' out=dummyout mom=-2 axis=3

fits in=dummyout out=${outfile} op=xyout

rm -rf dummyin
rm -rf dummyout
