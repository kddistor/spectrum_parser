#!/usr/bin/perl
###############################
#Spectrum Report Parser       #
#Pt 5 - Treatment Concatenator#
#by Kevin Distor              #
###############################

use strict;
use warnings;

# die: "usage: file_con <replicate1.ratio> <replicate2.ratio> <replicate3.ratio> <Output.txt>" unless @ARGV==4;

#   perl experiment_concatenator.pl A10.ratio B10.ratio C10.ratio test1.txt

#tic ratios A B C mean stdev flag

my $rep1 = $ARGV[0];
my $rep2 = $ARGV[1];
my $rep3 = $ARGV[2];
my $outfile = $ARGV[3];

open (INFILE1, "<$rep1") or die 'File cannot be opened\n\n';
open (INFILE2, "<$rep2") or die 'File cannot be opened\n\n';
open (INFILE3, "<$rep3") or die 'File cannot be opened\n\n';
open (OUTFILE, ">$outfile") or die 'File cannot be opened\n\n';

$rep1 =~ s/\.ratio//;
$rep2 =~ s/\.ratio//;
$rep3 =~ s/\.ratio//;

open (TEMP, ">temp.txt") or die 'File cannot be opened\n\n';
print TEMP "Peptide\tProteinName\tProteinAccessionNumber\tTicRatio$rep1.F/$rep1.H\tTicRatio$rep2.F/$rep2.H\tTicRatio$rep2.F/C$rep2.H\tScanRatio$rep1.F/$rep1.H\tScanRatio$rep2.F/$rep2.H\tScanRatio$rep2.F/C$rep2.H\tAmbiguousSite\n";

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

#if in a b c
foreach (keys %hash1) {
	if (exists $hash2{$_} && exists $hash3{$_}) {
		print TEMP "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[4]\t$hash1{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[3]\t$hash1{$_}[5]\n";
	}
}

#if in a b 
foreach (keys %hash1) {
	if (exists $hash2{$_}) {
		unless (exists $hash3{$_}) {
			print TEMP "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[4]\t$hash1{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[3]\tNA\tNA\t$hash1{$_}[5]\n";
		}
	}
}

#if in a
foreach (keys %hash1) {
	unless (exists $hash2{$_}) {
		unless (exists $hash3{$_}) {
		print TEMP "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[4]\t$hash1{$_}[3]\tNA\tNA\tNA\tNA\t$hash1{$_}[5]\n";
		}
	}
}

#if in   b c
foreach (keys %hash2) {
	if (exists $hash3{$_}) {
		unless (exists $hash1{$_}) {
			print TEMP "$_\t$hash2{$_}[1]\t$hash2{$_}[2]\tNA\tNA\t$hash2{$_}[4]\t$hash2{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[3]\t$hash2{$_}[5]\n";
		}
	}
}

#if in   b
foreach (keys %hash2) {
	unless (exists $hash3{$_}) {
		unless (exists $hash1{$_}) {
			print TEMP "$_\t$hash2{$_}[1]\t$hash2{$_}[2]\tNA\tNA\t$hash2{$_}[4]\t$hash2{$_}[3]\tNA\tNA\t$hash2{$_}[5]\n";
		}
	}
}

#if in a   c
foreach (keys %hash1) {
	if (exists $hash3{$_}) {
		unless (exists $hash2{$_}) {
		print TEMP "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[4]\t$hash1{$_}[3]\tNA\tNA\t$hash3{$_}[4]\t$hash3{$_}[3]\t$hash1{$_}[5]\n";
		}
	}
}

#if in     c
foreach (keys %hash3) {
	unless (exists $hash2{$_}) {
		unless (exists $hash1{$_}) {
			print TEMP "$_\t$hash3{$_}[1]\t$hash3{$_}[2]\tNA\tNA\tNA\tNA\t$hash3{$_}[4]\t$hash3{$_}[3]\t$hash3{$_}[5]\n";
		}
	}
}
close TEMP;
open (TEMP, "<temp.txt") or die 'File cannot be opened\n\n';
print OUTFILE "Peptide\tProteinName\tProteinAccessionNumber\tTicRatio$rep1.F/$rep1.H\tTicRatio$rep2.F/$rep2.H\tTicRatio$rep2.F/C$rep2.H\tScanRatio$rep1.F/$rep1.H\tScanRatio$rep2.F/$rep2.H\tScanRatio$rep2.F/C$rep2.H\t$rep1.AmbiguousSite\t$rep1.TicMean\t$rep1.TicStDev\t$rep1.ScanCountMean\n";
while(my $line=<TEMP>){
	next if $line=~m/Peptide/;
	chomp $line;
	my($peptide, $protein_name, $protein_accession, $rep1tic, $rep2tic, $rep3tic, $rep1scan, $rep2scan, $rep3scan, $flagged) = split(/\t/,$line);
	print OUTFILE "$peptide\t$protein_name\t$protein_accession\t$rep1tic\t$rep2tic\t$rep3tic\t$rep1scan\t$rep2scan\t$rep3scan\t$flagged\n";
	my @tic_array;
		if ($rep1tic =~ m/^d/) {
			push (@tic_array,$rep1tic);
		}
		if ($rep2tic =~ m/^d/) {
			push (@tic_array,$rep2tic);
		}
		if ($rep3tic =~ m/^d/) {
			push (@tic_array,$rep3tic);
		}
	if (@tic_array) {
		my $sum = eval join '+', @tic_array;
		my $mean = $sum/$#tic_array unless $#tic_array==0;
		chomp $mean;
		print OUTFILE "\t$mean\n";
	}
	# else {
		# print OUTFILE "NA\n";
	# }
	# undef @tic_array;
}
