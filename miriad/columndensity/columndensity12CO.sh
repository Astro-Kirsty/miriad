#!/bin/bash

# Code created Jun 2017 by Kirsty

# Miriad shell script to calculate column density for 12CO
# pg 808   Dame et al, 2001   The Astrophysical Journal, Volume 547, Issue 2, pp. 792-813
# arXiv:astro-ph/0009217

# to run, go to path where the fits file is:
# columndensity12CO.sh [fits infile] 

if [ $# != 1 ]; then
    echo
    echo Incorrect number of arguments given.
    echo
    echo To run correctly:
    echo    columndensity12CO.sh [fits infile] 
    echo
    exit 1
fi


infile=$1
head=`basename $infile .fits`
#outfile=${head}_12CO_column.fits
outfile=${head}_column.fits

echo
echo Making a column density map for 12CO in a given velocity range
echo using the input file ${infile}
echo


fits in=${infile} out=dummymir op=xyin
maths exp=dummymir*1.8*10**20 out=dummyout #options=unmask
fits in=dummyout out=${outfile} op=xyout

echo
echo Output file written to ${outfile}
echo

rm -rf dummymir
rm -rf dummyout

