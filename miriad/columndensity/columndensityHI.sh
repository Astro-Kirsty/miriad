#!/bin/bash

# Code created Jun 2017 by Kirsty

# Miriad shell script to calculate column density for HI
# Eq (3)    Dickey & Felix, 1990    Annual review of astronomy and astrophysics. Vol. 28 (A91-28201 10-90). Palo Alto, CA, Annual Reviews, Inc., 1990, p. 215-261
# DOI: 10.1146/annurev.aa.28.090190.001243

# columndensityHI.sh [fits infile] 

if [ $# != 1 ]; then
    echo
    echo Incorrect number of arguments given.
    echo
    echo To run correctly:
    echo    columndensityHI.sh [fits infile] 
    echo
    exit 1
fi

infile=$1
head=`basename $infile .fits`
outfile=${head}_column.fits

echo
echo Making a column density map for HI in a given velocity range
echo using the input file ${infile}
echo

fits in=${infile} out=dummymir op=xyin
maths exp=dummymir*1.823*10**18 out=dummyout #options=unmask
fits in=dummyout out=${outfile} op=xyout

echo
echo Output file written to ${outfile}
echo

rm -rf dummymir
rm -rf dummyout

