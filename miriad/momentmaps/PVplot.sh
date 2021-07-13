#!/bin/bash

# Code created September 2018 by Kirsty

# Miriad shell script to make Position Velocity (PV) plot in fits
# 

# to run, go to path where the fits file is:
# PVplot.sh [lat1] [lat2] [cube fits infile] 


if [ $# != 3 ]; then
    echo
    echo Incorrect number of arguments given.
    echo
    echo To run correctly:
    echo    PVplot.sh [lat1] [lat2] [cube fits infile] 
    echo
    echo   e.g. PVplot.sh -1.2 1.2 mopra_CO.fits
    echo
    exit 1
fi


lat1=$1
lat2=$2
infile=$3

head=`basename $infile .fits`
outfile=${head}_PVplot_${lat1}_${lat2}.fits


# Use for PV plots

echo
echo Creating file for PV plot
echo
fits in=${infile} out=dummyin op=xyin
echo
echo Reordering axes 
echo Swap y-axis and z-axis
echo
reorder in=dummyin out=reorderout mode=132
echo
echo Moment 0 map from ${lat1} to ${lat2} degrees latitude
echo
moment in=reorderout region="images(${lat1},${lat2})" out=dummyout mom=0 axis=3
fits in=dummyout op=xyout out=$outfile
echo
echo Output file written to ${outfile}
echo


rm -rf dummyin
rm -rf reorderout
rm -rf dummyout
