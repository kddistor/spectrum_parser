#!/usr/bin/perl

###############################
#Spectrum Report Parser       #
#  						  #
#by Kevin Distor              #
###############################


# use strict;
# use warnings;

# die: "<FILE.txt> <FILE.text> <Output.final> <peptide thresh> <xtandem thresh>" unless @ARGV==5;

my $infile = $ARGV[0];
my $temp = $ARGV[1];
my $outfile = $ARGV[2];
my $uThresh = $ARGV[3];
my $yThresh = $ARGV[4];


open (FILE, "<$infile") or die "No file\n\n";
open (TEMP, ">$temp") or die "No file\n\n";
open (OUTPUT, ">$outfile") or die "No file\n\n";

my $firstline = <FILE>;
print TEMP "$firstline";
my @file=<FILE>;

# make new array based on filtering criteria
my @filtered_file=();

foreach  my $line (@file){

	next if $line=~m/peptide/;
	my @linedata=split(/\t/,$line);
	
	# get peptide probability
	my $pep_prob=$linedata[20];
	# get x!tandem probability
	my $x_tan=$linedata[21];
	
	# push to array only lines that match peptide and x!tandem criteria 
	 if ($pep_prob > $uThresh && $x_tan > $yThresh){ push(@filtered_file,$line); }
}
close FILE;


#collapse by scan count and push 0's to flag ambiguous peptides
my %peptideseq_hash=();
for my $i (0..$#filtered_file){

	my @linedata=split(/\t/,$filtered_file[$i]);
	my $peptideseq=$linedata[17];
	my $specname=$linedata[16];
	my $allcaps_peptideseq=$peptideseq;
	$allcaps_peptideseq=~tr/a-z/A-Z/;

	if($peptideseq_hash{$specname}) {
		chomp $filtered_file[$peptideseq_hash{$specname}-1];
		$filtered_file[ $peptideseq_hash{$specname}-1 ] .= "0\n";
		$filtered_file[$i]="\n";
	}
	else{
		$peptideseq_hash{$specname}=$i+1;
	}
}

foreach my $line (@filtered_file){
	print TEMP $line unless $line=~m/^$/;
}

close TEMP;
open (TEMP, "<$temp") or die "nothing to see here\n\n";
# open TEMP, "<temp.text" or die "nothing to see here\n\n";

my $firstline1 = <TEMP>;
chomp $firstline1;
print OUTPUT "$firstline1\tScan Count\tSummedIntensities\tAmbiguousSite?\n";
my @file1=<TEMP>;
my @temp_array;
my @filtered_file1=();

foreach  my $line1 (@file1){
	next if $line1=~m/peptide/;
	my @linedata1=split(/\t/,$line1);
	if ($line1) { push(@filtered_file1,$line1); }
}
close TEMP;
my $count = 1;
my %peptideseq_hash1=();

#collapse by peptide and push collapsed tics to empty column
for my $i (0..$#filtered_file1){

	my @linedata1=split(/\t/,$filtered_file1[$i]);
	# print "$linedata1[17]";
	my $peptideseq1=$linedata1[17];
	my $specname1=$linedata1[16];
	my $total_ion_current=$linedata1[31];
	chomp $total_ion_current;
	my $allcaps_peptideseq1=$peptideseq1;
	$allcaps_peptideseq1=~tr/a-z/A-Z/;
	$count++;
	if($peptideseq_hash1{$allcaps_peptideseq1}) {
		chomp $filtered_file1[$peptideseq_hash1{$allcaps_peptideseq1}-1];
		$filtered_file1[$peptideseq_hash1{$allcaps_peptideseq1}-1] .= ",$total_ion_current\n";
		$filtered_file1[$i]="\n";
		
	}
	else{
		$peptideseq_hash1{$allcaps_peptideseq1}=$i+1;
		$count = 1;
	}
	
}

#count the number of scans per peptide
for my $i (0..$#filtered_file1){
	my @linedata1=split(/\t/,$filtered_file1[$i]);
	my $total_ion_current=$linedata1[31];
	my $last = ($linedata1[36] =~ tr/,//) + 1;
	chomp $last;
	chomp $filtered_file1[$i];
	if ($linedata1[36] eq "0\n") {$filtered_file1[$i] .= "\t1\n";}
	else {$filtered_file1[$i] .= "\t$last\n";}
}

#sum the tic collumn and the collapsed tic collumn
for my $i (0..$#filtered_file1){
	my @linedata1=split(/\t/,$filtered_file1[$i]);
	my $tic1=$linedata1[31];
	my $tic2=$linedata1[36];
	@temp_array = split(/,/, $tic2);
	push (@temp_array, $tic1);
	$sum = eval join '+', @temp_array;
	chomp $sum;
	chomp $filtered_file1[$i];
	$filtered_file1[$i] .= "\t$sum\n";
}

#find flagged peptides and report 
for my $i (0..$#filtered_file1){
	my @linedata1=split(/\t/,$filtered_file1[$i]);
	my $flagger=$linedata1[36];
	chomp $flagger;
	chomp $filtered_file1[$i];
	if ($flagger=~m/^0{2,}\,\d+/) {
		$filtered_file1[$i] .= "\tYes\n";
	}
	else {$filtered_file1[$i] .= "\tNo\n";}
}


foreach $_ (@filtered_file1){
	print OUTPUT $_ unless $_=~m/^\t\n/ || $_=~m/^\t1\t\n/ || $_=~m/^\t1\t\t\No/;
}
