#!/bin/bash

# Code created Mar 2018 by Kirsty

# Miriad shell script to calculate column density for 13CO
# Eq (2)   Simon et al, 2001    The Astrophysical Journal, Volume 551, Issue 2, pp. 747-763
# DOI: 10.1086/320230

# columndensity13CO.sh [fits infile] 

if [ $# != 1 ]; then
    echo
    echo Incorrect number of arguments given.
    echo
    echo To run correctly:
    echo    columndensity13CO.sh [fits infile] 
    echo
    exit 1
fi


infile=$1
head=`basename $infile .fits`
outfile=${head}_column.fits

echo
echo Making a column density map for 13CO in a given velocity range
echo using the input file ${infile}
echo

fits in=${infile} out=dummymir op=xyin
maths exp=dummymir*4.92*10**20 out=dummyout #options=unmask
fits in=dummyout out=${outfile} op=xyout

echo
echo Output file written to ${outfile}
echo

rm -rf dummymir
rm -rf dummyout
