#!/bin/bash

# Code created in Jul 2017 by Kirsty

# Miriad shell script to calculate ratio of molecular and atomic hydrogen
# ie molecular(NH2) / atomic(NHI)

# ratioH2toH1.sh [CO fits file] [HI fits file]

# both CO and HI file must be of the same km/s range

infileCO=$1
infileHI=$2

head=`basename $infileCO .fits`
outfile=${head}_ratio2.fits

echo
echo Creating a file for the ratio of molecular to atomic hydrogen
echo
echo ie ratio of CO to HI with input files ${infileCO} and ${infileHI} respectively
echo
echo Noting: inputs are in the same velocity range
echo


fits in=${infileCO} out=dummyCO op=xyin
fits in=${infileHI} out=dummyHI op=xyin
maths exp=dummyCO/dummyHI out=dummyout options=unmask
fits in=dummyout out=${outfile} op=xyout

echo
echo Output file written to ${outfile}
echo
echo

rm -rf dummyCO
rm -rf dummyHI
rm -rf dummyout
