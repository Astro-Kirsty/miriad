#!/bin/bash

# Code created in Aug 2018 by Kirsty

# Miriad shell script to combine two adjacent fits files

# combine_fits.sh [fits input1] [fits input2] [fits outfile]
# both files need to be in the form of a fits
# should use fits which are next to each other
# if using moment maps make sure they are the same velocity regions

# Specify in the last input (outfile) what you want the new file to be named

if [ $# != 3 ]; then
    echo
    echo Incorrect number of arguments given.
    echo
    echo To run correctly:
    echo    combine_fits.sh [fits input1] [fits input2] [outfile name] 
    echo
    echo   e.g. combine_fits.sh G008_CO.fits G009_CO.fits G008_G009_CO.fits
    echo
    echo   *We require 2 fits files that are adjacent as the inputs
    echo   
    exit 1
fi

infile1=$1
infile2=$2
outfile=$3

echo
echo Combining two files together that are adjacent to one another
echo The two adjacent input files are: ${infile1} and ${infile2}
echo
                                      
fits in=${infile1} op=xyin out=mirout1
fits in=${infile2} op=xyin out=mirout2                                
imcomb in='mirout1','mirout2' out='dummyout'
fits in=dummyout op=xyout out=${outfile}

echo
echo Output file written to ${outfile}
echo

rm -rf dummyout
rm -rf mirout1
rm -rf mirout2

