#!/usr/bin/perl

###############################
#Tic Ratio Displayer          #
#Pt 1  					  #
#by Kevin Distor              #
###############################

#peptide	proteinname	proteinaccessionnmber ticAF	ticAH	

#usage: perl tic_scan_displayer_1.pl 10minflg22_rep1.text.out.final 10minH2O_rep1.text.out.final A10ticscan.txt

my $flg = $ARGV[0];
my $h2o = $ARGV[1];
my $OUTFILE = $ARGV[2];

open (INFILE1, "<$flg") or die 'File cannot be opened\n\n';
open (INFILE2, "<$h2o") or die 'File cannot be opened\n\n';
open (OUTFILE, ">$OUTFILE") or die 'File cannot be opened\n\n';

print OUTFILE "Peptide\tProteinName\tProteinAccessionNumbers\tScanCountFlg22\tScanCountH2O\tSummedIntensitiesFlg22\tSummedIntensitiesH2O\tWhere\tFlagged\n";

my ($scan_count1, $scan_count2, $summed_intensities1, $summed_intensities2, @temp_array1, @temp_array2);

my %hash1;
while (<INFILE1>) {
	chomp;
	next if $_=~m/peptide/;
	my @linedata1 = split(/\t/);
	my $peptide1 = $linedata1[17];
	my $allcaps_peptide1=$peptide1;
	$allcaps_peptide1=~tr/a-z/A-Z/;
	$hash1{$allcaps_peptide1}= [@linedata1];
}

my %hash2;
while (<INFILE2>) {
	chomp;
	next if $_=~m/peptide/;
	my @linedata2 = split(/\t/);
	my $peptide2 = $linedata2[17];
	my $allcaps_peptide2=$peptide2;
	$allcaps_peptide2=~tr/a-z/A-Z/;
	$hash2{$allcaps_peptide2}= [@linedata2];
}



#for flg22 h2o
foreach (keys %hash1) {
	if (exists $hash2{$_} ) {
		print OUTFILE "$_\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[37]\t$hash2{$_}[37]\t$hash1{$_}[38]\t$hash2{$_}[38]\tBoth\t$hash1{$_}[39]\n";
	}
}

#for flg22
foreach (keys %hash1) {
	unless (exists $hash2{$_}) {
		print OUTFILE "$_\t$hash1{$_}[4]\t$hash1{$_}[5]\t$hash1{$_}[37]\tNA\t$hash1{$_}[38]\tNA\tFlg22Only\t$hash1{$_}[39]\n";
	}
}

#for h2o 
foreach (keys %hash2) {
	unless (exists $hash1{$_} ) {
		print OUTFILE "$_\t$hash2{$_}[4]\t$hash2{$_}[5]\tNA\t$hash2{$_}[37]\tNA\t$hash2{$_}[38]\tH2OOnly\t$hash2{$_}[39]\n";
	}
}
