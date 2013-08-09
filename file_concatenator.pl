#!/usr/bin/perl
###############################
#Spectrum Report Parser       #
#Pt 6 - File Concatenator     #
#by Kevin Distor              #
###############################

use strict;
use warnings;

# die: "usage: file_con <10min.txt> <03hrs.txt> <12hrsx.txt> <Output.txt>" unless @ARGV==4;

#   perl file_concatenator.pl 10min_fixed.txt 03hrs_fixed.txt 12hrs_fixed.txt final.txt

#tic ratios A B C mean stdev flag
#TicRatioA10minF/A10minH 	TicRatioB10minF/B10minH 	TicRatioC10minF/C10minH 	ScanA10minF/A10minH 	ScanB10minF/B10minH 	ScanC10minF/C10minH 


my $ten_min = $ARGV[0];
my $three_hrs = $ARGV[1];
my $twelve_hrs = $ARGV[2];
my $outfile = $ARGV[3];

open (INFILE1, "<$ten_min") or die 'File cannot be opened\n\n';
open (INFILE2, "<$three_hrs") or die 'File cannot be opened\n\n';
open (INFILE3, "<$twelve_hrs") or die 'File cannot be opened\n\n';
open (OUTFILE, ">$outfile") or die 'File cannot be opened\n\n';

$ten_min =~ s/\.txt//;
$three_hrs =~ s/\.txt//;
$twelve_hrs =~ s/\.txt//;

print OUTFILE "Peptide\tProteinName\tProteinAccessionNumber\tTicRatioA$ten_min.F/A$ten_min.H\tTicRatioB$ten_min.F/B$ten_min.H\tTicRatioC$ten_min.F/C$ten_min.H\tScanRatioA$ten_min.F/A$ten_min.H\tScanRatioB$ten_min.F/B$ten_min.H\tScanRatioC$ten_min.F/C$ten_min.H\tTicMean$ten_min\tTicStDev$ten_min\tScanMean$ten_min\tScanStDev$ten_min\tAmbiguousSite$ten_min\tTicRatioA$three_hrs.F/A$three_hrs.H\tTicRatioB$three_hrs.F/B$three_hrs.H\tTicRatioC$three_hrs.F/C$three_hrs.H\tScanRatioA$three_hrs.F/A$three_hrs.H\tScanRatioB$three_hrs.F/B$three_hrs.H\tScanRatioC$three_hrs.F/C$three_hrs.H\tTicMean$three_hrs\tTicStDev$three_hrs\tScanMean$three_hrs\tScanStDev$three_hrs\tAmbiguousSite$three_hrs\tTicRatioA$twelve_hrs.F/A$twelve_hrs.H\tTicRatioB$twelve_hrs.F/B$twelve_hrs.H\tTicRatioC$twelve_hrs.F/C$twelve_hrs.H\tScanRatioA$twelve_hrs.F/A$twelve_hrs.H\tScanRatioB$twelve_hrs.F/B$twelve_hrs.H\tScanRatioC$twelve_hrs.F/C$twelve_hrs.H\tTicMean$twelve_hrs\tTicStDev$twelve_hrs\tScanMean$twelve_hrs\tScanStDev$twelve_hrs\tAmbiguousSite$twelve_hrs\n";

# \tScanRatioA$ten_min.F/A$ten_min.H\tScanRatioB$ten_min.F/B$ten_min.H\tScanRatioC$ten_min.F/C$ten_min.H
# \tScanRatioA$three_hrs.F/A$three_hrs.H\tScanRatioB$three_hrs.F/B$three_hrs.H\tScanRatioC$three_hrs.F/C$three_hrs.H
# \tScanRatioA$twelve_hrs.F/A$twelve_hrs.H\tScanRatioB$twelve_hrs.F/B$twelve_hrs.H\tScanRatioC$twelve_hrs.F/C$twelve_hrs.H

my (@linedata1, @linedata2, @linedata3, $peptide1, $peptide2, $peptid3);

my %hash1;
while (<INFILE1>) {
	chomp;
	next if $_=~m/Peptide/;
	@linedata1 = split(/\t/);
	my $peptide1 = $linedata1[0];
	$hash1{$peptide1}= [@linedata1];
}

my %hash2;
while (<INFILE2>) {
	chomp;
	next if $_=~m/Peptide/;
	@linedata2 = split(/\t/);
	my $peptide2 = $linedata2[0];
	$hash2{$peptide2}= [@linedata2];
}

my %hash3;
while (<INFILE3>) {
	chomp;
	next if $_=~m/Peptide/;
	@linedata3 = split(/\t/);
	my $peptide3 = $linedata3[0];
	$hash3{$peptide3}= [@linedata3];
}

my (@temp_array1, @temp_array2, @temp_array3); 

# if in 10min 03hrs 12hrs
foreach (keys %hash1) {
	if (exists $hash2{$_} && exists $hash3{$_}) {
		print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[7]\t$hash1{$_}[8]\t$hash1{$_}[10]\t$hash1{$_}[11]\t$hash1{$_}[12]\t$hash1{$_}[13]\t$hash1{$_}[9]\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[7]\t$hash2{$_}[8]\t$hash2{$_}[10]\t$hash2{$_}[11]\t$hash2{$_}[12]\t$hash2{$_}[13]\t$hash2{$_}[9]\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[7]\t$hash3{$_}[8]\t$hash3{$_}[10]\t$hash3{$_}[11]\t$hash3{$_}[12]\t$hash3{$_}[13]\t$hash3{$_}[9]\n";
	}
}

# \t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[7]\t$hash1{$_}[8]
# \t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[7]\t$hash2{$_}[8]
# \t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[7]\t$hash3{$_}[8]

# if in 10min 03hrs
foreach (keys %hash1) {
	if (exists $hash2{$_}) {
		unless (exists $hash3{$_}) {
			print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[7]\t$hash1{$_}[8]\t$hash1{$_}[10]\t$hash1{$_}[11]\t$hash1{$_}[12]\t$hash1{$_}[13]\t$hash1{$_}[9]\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[7]\t$hash2{$_}[8]\t$hash2{$_}[10]\t$hash2{$_}[11]\t$hash2{$_}[12]\t$hash2{$_}[13]\t$hash2{$_}[9]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
		}
	}
}


# if in 10min 
foreach (keys %hash1) {
	unless (exists $hash2{$_}) {
		unless (exists $hash3{$_}) {
			print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[7]\t$hash1{$_}[8]\t$hash1{$_}[10]\t$hash1{$_}[11]\t$hash1{$_}[12]\t$hash1{$_}[13]\t$hash1{$_}[9]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
		}
	}
}


#if in   03hrs 12hrs
foreach (keys %hash2) {
	if (exists $hash3{$_}) {
		unless (exists $hash1{$_}) {
			print OUTFILE "$_\t$hash2{$_}[1]\t$hash2{$_}[2]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[7]\t$hash2{$_}[8]\t$hash2{$_}[10]\t$hash2{$_}[11]\t$hash2{$_}[12]\t$hash2{$_}[13]\t$hash2{$_}[9]\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[7]\t$hash3{$_}[8]\t$hash3{$_}[10]\t$hash3{$_}[11]\t$hash3{$_}[12]\t$hash3{$_}[13]\t$hash3{$_}[9]\n";
		}
	}
}

# if in   03hrs
foreach (keys %hash2) {
	unless (exists $hash3{$_}) {
		unless (exists $hash1{$_}) {
			print OUTFILE "$_\t$hash2{$_}[1]\t$hash2{$_}[2]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[7]\t$hash2{$_}[8]\t$hash2{$_}[10]\t$hash2{$_}[11]\t$hash2{$_}[12]\t$hash2{$_}[13]\t$hash2{$_}[9]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
		}
	}
}

# if in 10mins   12hrs
foreach (keys %hash1) {
	if (exists $hash3{$_}) {
		unless (exists $hash2{$_}) {
			print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[7]\t$hash1{$_}[8]\t$hash1{$_}[10]\t$hash1{$_}[11]\t$hash1{$_}[12]\t$hash1{$_}[13]\t$hash1{$_}[9]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[7]\t$hash3{$_}[8]\t$hash3{$_}[10]\t$hash3{$_}[11]\t$hash3{$_}[12]\t$hash3{$_}[13]\t$hash3{$_}[9]\n";
		}
	}
}

# if in     12hrs
foreach (keys %hash3) {
	unless (exists $hash2{$_}) {
		unless (exists $hash1{$_}) {
			print OUTFILE "$_\t$hash3{$_}[1]\t$hash3{$_}[2]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[7]\t$hash3{$_}[8]\t$hash3{$_}[10]\t$hash3{$_}[11]\t$hash3{$_}[12]\t$hash3{$_}[13]\t$hash3{$_}[9]\n";
		}
	}
}
