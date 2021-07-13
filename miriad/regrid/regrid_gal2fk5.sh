#!/bin/bash

# Code created Jun 2017 by Kirsty

# Miriad shell-script

# regrid from Gal to J2000 coords

infile=$BASH_ARGV

rm -Rf miriad.out > /dev/null
rm -Rf regrid.out > /dev/null
rm -rf *.def > /dev/null

head=`basename $infile .fits`
outfile=${head}_fk5.fits

fits in=${infile} op=xyin out=miriad.out
regrid in=miriad.out out=regrid.out options=galeqsw,offset,equisw project=tan
fits in=regrid.out op=xyout out=$outfile

rm -rf *.def regrid.out miriad.out


