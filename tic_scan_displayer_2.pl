#!/usr/bin/perl

###############################
#Tic Ratio Displayer          #
#Pt 2  					  #
#by Kevin Distor              #
###############################



#usage: perl tic_scan_displayer_2.pl A10ticscan.txt B10ticscan.txt C10ticscan.txt testticscan.txt


my $rep1 = $ARGV[0];
my $rep2 = $ARGV[1];
my $rep3 = $ARGV[2];
my $outfile = $ARGV[3];

open (INFILE1, "<$rep1") or die 'File cannot be opened\n\n';
open (INFILE2, "<$rep2") or die 'File cannot be opened\n\n';
open (INFILE3, "<$rep3") or die 'File cannot be opened\n\n';
open (OUTFILE, ">$outfile") or die 'File cannot be opened\n\n';

$rep1 =~ s/\.txt//;
$rep2 =~ s/\.txt//;
$rep3 =~ s/\.txt//;

print OUTFILE "Peptide\tProteinName\tProteinAccessionNumber\tScanCountFlg22$rep1\tScanCountH2O$rep1\tSummedIntensitiesFlg22$rep1\tSummedIntensitiesH2O$rep1\tFlagged$rep1\tScanCountFlg22$rep2\tScanCountH2O$rep2\tSummedIntensitiesFlg22$rep2\tSummedIntensitiesH2O$rep2\tFlagged$rep2\tScanCountFlg22$rep3\tScanCountH2O$rep3\tSummedIntensitiesFlg22$rep3\tSummedIntensitiesH2O$rep1\tFlagged$rep3\n";

my (@linedata1, @linedata2, @linedata3, $peptide1, $peptide2, $peptide3);

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
		print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[8]\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[8]\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[8]\n";
	}
}
# $_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[8]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[8]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[8]\n";

#if in a b 
foreach (keys %hash1) {
	if (exists $hash2{$_}) {
		unless (exists $hash3{$_}) {
			print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[8]\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[8]\tNA\tNA\tNA\tNA\tNA\n";
		}
	}
}

#if in a
foreach (keys %hash1) {
	unless (exists $hash2{$_}) {
		unless (exists $hash3{$_}) {
		print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[8]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
		}
	}
}

#if in   b c
foreach (keys %hash2) {
	if (exists $hash3{$_}) {
		unless (exists $hash1{$_}) {
			print OUTFILE "$_\t$hash2{$_}[1]\t$hash2{$_}[2]\tNA\tNA\tNA\tNA\tNA\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[8]\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[8]\n";
		}
	}
}

#if in   b
foreach (keys %hash2) {
	unless (exists $hash3{$_}) {
		unless (exists $hash1{$_}) {
			print OUTFILE "$_\t$hash2{$_}[1]\t$hash2{$_}[2]\tNA\tNA\tNA\tNA\tNA\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[8]\tNA\tNA\tNA\tNA\tNA\n";
		}
	}
}

#if in a   c
foreach (keys %hash1) {
	if (exists $hash3{$_}) {
		unless (exists $hash2{$_}) {
		print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[8]\tNA\tNA\tNA\tNA\tNA\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[8]\n";
		}
	}
}

#if in     c
foreach (keys %hash3) {
	unless (exists $hash2{$_}) {
		unless (exists $hash1{$_}) {
			print OUTFILE "$_\t$hash3{$_}[1]\t$hash3{$_}[2]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[8]\n";
		}
	}
}
