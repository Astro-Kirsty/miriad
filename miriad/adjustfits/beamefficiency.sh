#!/bin/bash

# Code created Jun 2018 by Kirsty

# Miriad shell script to multiply by the Mopra beam efficiency
# n_XB = 0.55
# Sec (2)   Burton et al, 2013   Publications of the Astronomical Society of Australia, Volume 30, id.e044 28 pp
# arXiv:1307.1027

# beamefficiency.sh [fits infile] 

infile=$1
head=`basename $infile .fits`
outfile=${head}-n_XB.fits

echo
echo Correcting for a beam efficiency of 0.55
echo Input file ${infile}
echo

fits in=${infile} out=dummymir op=xyin
# CO beam efficiency is 0.55
#maths exp=dummymir/0.55 out=dummyout #options=unmask

# Paper for 7mm: Characterisation of the Mopra Radio Telescope at 16–50 GHz
# CS @ 49GHz beam efficiency is 0.56
#maths exp=dummymir/0.56 out=dummyout

# SiO @ 43GHz beam efficiency is 0.69
#maths exp=dummymir/0.69 out=dummyout

# HC3N @ 45GHz beam efficiency is 0.67
maths exp=dummymir/0.67 out=dummyout

# CH3OH @ 44GHz - either HC3N or SiO

fits in=dummyout out=${outfile} op=xyout



echo
echo Output file written to ${outfile}
echo

rm -rf dummymir
rm -rf dummyout
