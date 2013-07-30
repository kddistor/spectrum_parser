#!/usr/bin/perl
###############################
#Spectrum Report Parser       #
#Pt 4 -Ratio Generator  	  #
#by Kevin Distor              #
###############################

use strict;
use warnings;

# die: "usage: ratio_generator.pl <flg22.txt> <h20.text> <Output.final>" unless @ARGV==3;
# perl ratio_generator2.pl 10minflg22_rep1.text.out.final 10minH2O_rep1.text.out.final A10.ratio
# perl ratio_generator.pl test1.txt test2.txt test.txt

my $flg = $ARGV[0];
my $h2o = $ARGV[1];
my $OUTFILE = $ARGV[2];

open (INFILE1, "<$flg") or die 'File cannot be opened\n\n';
open (INFILE2, "<$h2o") or die 'File cannot be opened\n\n';
open (OUTFILE, ">$OUTFILE") or die 'File cannot be opened\n\n';

open (TEMP, ">temp.txt") or die 'File cannot be opened\n\n';
print TEMP "Peptide\tProteinName\tProteinAccessionNumbers\tScanCountFlg22\tScanCountH2O\tSummedIntensitiesFlg22\tSummedIntensitiesH2O\tWhere\tFlagged\n";

my ($scan_count1, $scan_count2, $summed_intensities1, $summed_intensities2, @temp_array1, @temp_array2);

my %hash1;
while (<INFILE1>) {
	next if $_=~m/peptide/;
	my @linedata1 = split(/\t/);
	my $peptide1 = $linedata1[17];
	my $allcaps_peptide1=$peptide1;
	$allcaps_peptide1=~tr/a-z/A-Z/;
	$hash1{$allcaps_peptide1}= [@linedata1];
}

my %hash2;
while (<INFILE2>) {
	next if $_=~m/peptide/;
	my @linedata2 = split(/\t/);
	my $peptide2 = $linedata2[17];
	my $allcaps_peptide2=$peptide2;
	$allcaps_peptide2=~tr/a-z/A-Z/;
	$hash2{$allcaps_peptide2}= [@linedata2];
}

foreach (keys %hash2) {
	@temp_array2 = @{$hash2{$_}};
	chomp @temp_array2;
	if (exists $hash1{$_} ) {}
	else {
	print TEMP "$_\t$temp_array2[4]\t$temp_array2[5]\t0\t$temp_array2[37]\t0\t$temp_array2[38]\tH2OOnly\t$temp_array2[39]\n";
	}
}

foreach (keys %hash1) {
	@temp_array1 = @{$hash1{$_}};
	chomp @temp_array1;
	if (exists $hash2{$_} ) {
		print TEMP "$_\t$temp_array1[4]\t$temp_array1[5]\t$temp_array1[37]\t$temp_array2[37]\t$temp_array1[38]\t$temp_array2[38]\tBoth\t$temp_array1[39]\n";
		next;
	}
	else {print TEMP "$_\t$temp_array1[4]\t$temp_array1[5]\t$temp_array1[37]\t0\t$temp_array1[38]\t0\tFlg22Only\t$temp_array1[39]\n";}
}

close TEMP;
open (TEMP, "<temp.txt") or die 'File cannot be opened\n\n';

print OUTFILE "Peptide\tProteinName\tProteinAccessionNumbers\tScanCountRatio\tTicRatio\tAmbiguousSite\n";
while(my $line=<TEMP>){
	next if $line=~m/Peptide/;
	chomp $line;
	my ($peptide, $protein_name, $accession, $flg22_scancount, $h20_scancount, $flg22_tic, $h20_tic, $location, $flagged) = split(/\t/,$line);
	print OUTFILE "$peptide\t$protein_name\t$accession\t";
	if ($flg22_scancount == 0) {
		print OUTFILE "error - 0\t";
	} elsif( $h20_scancount == 0) {
		print OUTFILE "error - inf\t";
	} else { my $scancount_ratio = $flg22_scancount/$h20_scancount;
		print OUTFILE "$scancount_ratio\t";
	}
	
	if ($flg22_tic == 0) {
		print OUTFILE "error - 0\t$flagged\n";
	} elsif($h20_tic == 0) {
		print OUTFILE "error - inf\t$flagged\n";
	} else {my $tic_ratio = $flg22_tic/$h20_tic;
		print OUTFILE "$tic_ratio\t$flagged\n";
	}
}	

