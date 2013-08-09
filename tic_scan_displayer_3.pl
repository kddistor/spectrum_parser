#!/usr/bin/perl

###############################
#Tic Ratio Displayer          #
#Pt 3  					  #
#by Kevin Distor              #
###############################

# die: "usage: file_con <10min.txt> <03hrs.txt> <12hrsx.txt> <Output.txt>" unless @ARGV==4;

#	 perl tic_scan_displayer_3.pl 10minticscan.txt 03hrsticscan.txt 12hrsticscan.txt finalticscan.txt

# 3 for title, 15 titles for 10 mins, 15 titles for 03 hours, 15 titles for 12 hrs
#ScanCountFlg22B03ticscan	ScanCountH2OB03ticscan	SummedIntensitiesFlg22B03ticscan	SummedIntensitiesH2OB03ticscan	FlaggedB03ticscan


my $ten_min = $ARGV[0];
my $three_hrs = $ARGV[1];
my $twelve_hrs = $ARGV[2];
my $outfile = $ARGV[3];

open (INFILE1, "<$ten_min") or die 'File cannot be opened\n\n';
open (INFILE2, "<$three_hrs") or die 'File cannot be opened\n\n';
open (INFILE3, "<$twelve_hrs") or die 'File cannot be opened\n\n';
open (OUTFILE, ">$outfile") or die 'File cannot be opened\n\n';

print OUTFILE "Peptide\tProteinName\tProteinAccessionNumber\tScanCountFlg22A10\tScanCountH2OA10\tSummedIntensitiesFlg22A10\tSummedIntensitiesH2OA10\tAmbiguousSiteA10\tScanCountFlg22B10\tScanCountH2OB10\tSummedIntensitiesFlg22B10\tSummedIntensitiesH2OB10\tAmbiguousSiteB10\tScanCountFlg22C10\tScanCountH2OC10\tSummedIntensitiesFlg22C10\tSummedIntensitiesH2OC10\tAmbiguousSiteC10\tScanCountFlg22A03\tScanCountH2OA03\tSummedIntensitiesFlg22A03\tSummedIntensitiesH2OA03\tAmbiguousSiteA03\tScanCountFlg22B03\tScanCountH2OB03\tSummedIntensitiesFlg22B03\tSummedIntensitiesH2OB03\tAmbiguousSiteB03\tScanCountFlg22C03\tScanCountH2OC03\tSummedIntensitiesFlg22C03\tSummedIntensitiesH2OC03\tAmbiguousSiteC03\tScanCountFlg22A12\tScanCountH2OA12\tSummedIntensitiesFlg22A12\tSummedIntensitiesH2OA12\tAmbiguousSiteA12\tScanCountFlg22B12\tScanCountH2OB12\tSummedIntensitiesFlg22B12\tSummedIntensitiesH2OB12\tAmbiguousSiteB12\tScanCountFlg22C12\tScanCountH2OC12\tSummedIntensitiesFlg22C12\tSummedIntensitiesH2OC12\tAmbiguousSiteC12\n";

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
		print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[7]\t$hash1{$_}[8]\t$hash1{$_}[9]\t$hash1{$_}[10]\t$hash1{$_}[11]\t$hash1{$_}[12]\t$hash1{$_}[13]\t$hash1{$_}[14]\t$hash1{$_}[15]\t$hash1{$_}[16]\t$hash1{$_}[17]\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[7]\t$hash2{$_}[8]\t$hash2{$_}[9]\t$hash2{$_}[10]\t$hash2{$_}[11]\t$hash2{$_}[12]\t$hash2{$_}[13]\t$hash2{$_}[14]\t$hash2{$_}[15]\t$hash2{$_}[16]\t$hash2{$_}[17]\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[7]\t$hash3{$_}[8]\t$hash3{$_}[9]\t$hash3{$_}[10]\t$hash3{$_}[11]\t$hash3{$_}[12]\t$hash3{$_}[13]\t$hash3{$_}[14]\t$hash3{$_}[15]\t$hash3{$_}[16]\t$hash3{$_}[17]\n";
	}
}
# "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[7]\t$hash1{$_}[8]\t$hash1{$_}[9]\t$hash1{$_}[10]\t$hash1{$_}[11]\t$hash1{$_}[12]\t$hash1{$_}[13]\t$hash1{$_}[14]\t$hash1{$_}[15]\t$hash1{$_}[16]\t$hash1{$_}[17]\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[7]\t$hash2{$_}[8]\t$hash2{$_}[9]\t$hash2{$_}[10]\t$hash2{$_}[11]\t$hash2{$_}[12]\t$hash2{$_}[13]\t$hash2{$_}[14]\t$hash2{$_}[15]\t$hash2{$_}[16]\t$hash2{$_}[17]\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[7]\t$hash3{$_}[8]\t$hash3{$_}[9]\t$hash3{$_}[10]\t$hash3{$_}[11]\t$hash3{$_}[12]\t$hash3{$_}[13]\t$hash3{$_}[14]\t$hash3{$_}[15]\t$hash3{$_}[16]\t$hash3{$_}[17]\n";
# \tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA


# if in 10min 03hrs
foreach (keys %hash1) {
	if (exists $hash2{$_}) {
		unless (exists $hash3{$_}) {
			print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[7]\t$hash1{$_}[8]\t$hash1{$_}[9]\t$hash1{$_}[10]\t$hash1{$_}[11]\t$hash1{$_}[12]\t$hash1{$_}[13]\t$hash1{$_}[14]\t$hash1{$_}[15]\t$hash1{$_}[16]\t$hash1{$_}[17]\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[7]\t$hash2{$_}[8]\t$hash2{$_}[9]\t$hash2{$_}[10]\t$hash2{$_}[11]\t$hash2{$_}[12]\t$hash2{$_}[13]\t$hash2{$_}[14]\t$hash2{$_}[15]\t$hash2{$_}[16]\t$hash2{$_}[17]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
		}
	}
}


# if in 10min 
foreach (keys %hash1) {
	unless (exists $hash2{$_}) {
		unless (exists $hash3{$_}) {
			print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[7]\t$hash1{$_}[8]\t$hash1{$_}[9]\t$hash1{$_}[10]\t$hash1{$_}[11]\t$hash1{$_}[12]\t$hash1{$_}[13]\t$hash1{$_}[14]\t$hash1{$_}[15]\t$hash1{$_}[16]\t$hash1{$_}[17]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
		}
	}
}


#if in   03hrs 12hrs
foreach (keys %hash2) {
	if (exists $hash3{$_}) {
		unless (exists $hash1{$_}) {
			print OUTFILE "$_\t$hash2{$_}[1]\t$hash2{$_}[2]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[7]\t$hash2{$_}[8]\t$hash2{$_}[9]\t$hash2{$_}[10]\t$hash2{$_}[11]\t$hash2{$_}[12]\t$hash2{$_}[13]\t$hash2{$_}[14]\t$hash2{$_}[15]\t$hash2{$_}[16]\t$hash2{$_}[17]\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[7]\t$hash3{$_}[8]\t$hash3{$_}[9]\t$hash3{$_}[10]\t$hash3{$_}[11]\t$hash3{$_}[12]\t$hash3{$_}[13]\t$hash3{$_}[14]\t$hash3{$_}[15]\t$hash3{$_}[16]\t$hash3{$_}[17]\n";
		}
	}
}

# if in   03hrs
foreach (keys %hash2) {
	unless (exists $hash3{$_}) {
		unless (exists $hash1{$_}) {
			print OUTFILE "$_\t$hash2{$_}[1]\t$hash2{$_}[2]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash2{$_}[3]\t$hash2{$_}[4]\t$hash2{$_}[5]\t$hash2{$_}[6]\t$hash2{$_}[7]\t$hash2{$_}[8]\t$hash2{$_}[9]\t$hash2{$_}[10]\t$hash2{$_}[11]\t$hash2{$_}[12]\t$hash2{$_}[13]\t$hash2{$_}[14]\t$hash2{$_}[15]\t$hash2{$_}[16]\t$hash2{$_}[17]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
		}
	}
}

# if in 10mins   12hrs
foreach (keys %hash1) {
	if (exists $hash3{$_}) {
		unless (exists $hash2{$_}) {
			print OUTFILE "$_\t$hash1{$_}[1]\t$hash1{$_}[2]\t$hash1{$_}[3]\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[6]\t$hash1{$_}[7]\t$hash1{$_}[8]\t$hash1{$_}[9]\t$hash1{$_}[10]\t$hash1{$_}[11]\t$hash1{$_}[12]\t$hash1{$_}[13]\t$hash1{$_}[14]\t$hash1{$_}[15]\t$hash1{$_}[16]\t$hash1{$_}[17]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[7]\t$hash3{$_}[8]\t$hash3{$_}[9]\t$hash3{$_}[10]\t$hash3{$_}[11]\t$hash3{$_}[12]\t$hash3{$_}[13]\t$hash3{$_}[14]\t$hash3{$_}[15]\t$hash3{$_}[16]\t$hash3{$_}[17]\n";
		}
	}
}

# if in     12hrs
foreach (keys %hash3) {
	unless (exists $hash2{$_}) {
		unless (exists $hash1{$_}) {
			print OUTFILE "$_\t$hash3{$_}[1]\t$hash3{$_}[2]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash3{$_}[3]\t$hash3{$_}[4]\t$hash3{$_}[5]\t$hash3{$_}[6]\t$hash3{$_}[7]\t$hash3{$_}[8]\t$hash3{$_}[9]\t$hash3{$_}[10]\t$hash3{$_}[11]\t$hash3{$_}[12]\t$hash3{$_}[13]\t$hash3{$_}[14]\t$hash3{$_}[15]\t$hash3{$_}[16]\t$hash3{$_}[17]\n";
		}
	}
}
