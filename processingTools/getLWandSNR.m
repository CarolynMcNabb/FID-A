%getLWandSNR.m
%Jamie Near, McGill University 2014.
%
%USAGE:
%[ FWHM,SNR ] = getLWandSNR(in);
%
%DESCRIPTION:
%calculate the linewidth and SNR of a spectrum.  This function calculates
%the Linewidth by measuring the FWHM of the unsuppressed water peak.  SNR
%is calculated by measuring the height of the NAA peak and comparing this
%to the standard deviation of the noise in a signal-free region of the
%spectrum.  SNR is measured four separate times using four different noise 
%regions and the average of those four measurements is reported.
%
%INPUTS:
%in    = input data in matlab structure format

function [ FWHM,SNR ] = getLWandSNR(in);

%FIRST CALCULATE TWO DIFFERENT ESTIMATES OF LINEWIDTH (FWHM1 and FWHM2)
zpfactor=4;
H2Oppmmin=4;
H2Oppmmax=6;

 [FWHM]=getLW(in,zpfactor,H2Oppmmin,H2Oppmmax);

%NOW CALCULATE FOUR DIFFERENT ESTIMATES OF SNR (SNR1, SNR2, SNR3 and SNR4), 
%each using a different frequency range for noise estimation;
NAAppmmin=1.8;
NAAppmmax=2.25;
noiseppmmin1=-5;
noiseppmmax1=-3;
noiseppmmin2=-3;
noiseppmmax2=-1;
noiseppmmin3=10;
noiseppmmax3=12;
noiseppmmin4=12;
noiseppmmax4=14;
SNR1=getSNR(in,NAAppmmin,NAAppmmax,noiseppmmin1,noiseppmmax1);
SNR2=getSNR(in,NAAppmmin,NAAppmmax,noiseppmmin2,noiseppmmax2);
SNR3=getSNR(in,NAAppmmin,NAAppmmax,noiseppmmin3,noiseppmmax3);
SNR4=getSNR(in,NAAppmmin,NAAppmmax,noiseppmmin4,noiseppmmax4);


%NOW TAKE THE AVERAGE OF THE TWO ESTIMATES:
SNR=mean([SNR1,SNR2,SNR3,SNR4]);

end



