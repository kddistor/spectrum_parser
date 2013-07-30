#!/usr/bin/perl
###############################
#Spectrum Report Parser       #
#File Splitter                #
#by Kevin Distor              #
###############################


use strict;
use warnings;

# die "<Input>" unless @ARGV==1;

my $infile = $ARGV[0];

open (MASTER, "<$infile") or die 'File cannot be opened\n\n';
open FILE1, '>10minH2O_rep1.text' or die 'File cannot be opened\n\n';
open FILE2, '>10minH2O_rep2.text' or die 'File cannot be opened\n\n';
open FILE3, '>10minH2O_rep3.text' or die 'File cannot be opened\n\n';
open FILE4, '>03hrH2O_rep1.text' or die 'File cannot be opened\n\n';
open FILE5, '>03hrH2O_rep2.text' or die 'File cannot be opened\n\n';
open FILE6, '>03hrH2O_rep3.text' or die 'File cannot be opened\n\n';
open FILE7, '>12hrH2O_rep1.text' or die 'File cannot be opened\n\n';
open FILE8, '>12hrH2O_rep2.text' or die 'File cannot be opened\n\n';
open FILE9, '>12hrH2O_rep3.text' or die 'File cannot be opened\n\n';
open FILE10, '>10minflg22_rep1.text' or die 'File cannot be opened\n\n';
open FILE11, '>10minflg22_rep2.text' or die 'File cannot be opened\n\n';
open FILE12, '>10minflg22_rep3.text' or die 'File cannot be opened\n\n';
open FILE13, '>03hrflg22_rep1.text' or die 'File cannot be opened\n\n';
open FILE14, '>03hrflg22_rep2.text' or die 'File cannot be opened\n\n';
open FILE15, '>03hrflg22_rep3.text' or die 'File cannot be opened\n\n';
open FILE16, '>12hrflg22_rep1.text' or die 'File cannot be opened\n\n';
open FILE17, '>12hrflg22_rep2.text' or die 'File cannot be opened\n\n';
open FILE18, '>12hrflg22_rep3.text' or die 'File cannot be opened\n\n';

my $i;

my $firstline = <MASTER>;
print FILE1 "$firstline";
print FILE2 "$firstline";
print FILE3 "$firstline";
print FILE4 "$firstline";
print FILE5 "$firstline";
print FILE6 "$firstline";
print FILE7 "$firstline";
print FILE8 "$firstline";
print FILE9 "$firstline";
print FILE10 "$firstline";
print FILE11 "$firstline";
print FILE12 "$firstline";
print FILE13 "$firstline";
print FILE14 "$firstline";
print FILE15 "$firstline";
print FILE16 "$firstline";
print FILE17 "$firstline";
print FILE18 "$firstline";

foreach  my $line (<MASTER>){
  next if $line=~m/peptide/;
	my @linedata=split(/\t/,$line);

	# get biological sample category
	my $biosample_cat=$linedata[1];
	# get biological sample name
	my $biosample_name=$linedata[2];

	
	if ($biosample_cat eq '10min H2O' && $biosample_name eq '10min H2O Rep1') { chomp $line; print FILE1 "$line\n"; }
	if ($biosample_cat eq '10min H2O' && $biosample_name eq '10min H2O Rep2') {chomp $line; print FILE2 "$line\n"; }
	if ($biosample_cat eq '10min H2O' && $biosample_name eq '10min H2O Rep3') {chomp $line; print FILE3 "$line\n"; }
	if ($biosample_cat eq '03hr H2O' && $biosample_name eq '03hr H2O Rep1') {  chomp $line; print FILE4 "$line\n"; }
	if ($biosample_cat eq '03hr H2O' && $biosample_name eq '03hr H2O Rep2') {  chomp $line; print FILE5 "$line\n"; }
	if ($biosample_cat eq '03hr H2O' && $biosample_name eq '03hr H2O Rep3') {  chomp $line; print FILE6 "$line\n"; }
	if ($biosample_cat eq '12hr H2O' && $biosample_name eq '12hr H2O Rep1') {  chomp $line; print FILE7 "$line\n"; }
	if ($biosample_cat eq '12hr H2O' && $biosample_name eq '12hr H2O Rep2') {  chomp $line; print FILE8 "$line\n"; }
	if ($biosample_cat eq '12hr H2O' && $biosample_name eq '12hr H2O Rep3') {  chomp $line; print FILE9 "$line\n"; }
	if ($biosample_cat eq '10min flg22' && $biosample_name eq '10min flg22 Rep1') {  chomp $line; print FILE10 "$line\n"; }
	if ($biosample_cat eq '10min flg22' && $biosample_name eq '10min flg22 Rep2') {  chomp $line; print FILE11 "$line\n"; }
	if ($biosample_cat eq '10min flg22' && $biosample_name eq '10min flg22 Rep3') {  chomp $line; print FILE12 "$line\n"; }
	if ($biosample_cat eq '03hr flg22' && $biosample_name eq '03hr flg22 Rep1') {  chomp $line; print FILE13 "$line\n"; }
	if ($biosample_cat eq '03hr flg22' && $biosample_name eq '03hr flg22 Rep2') {  chomp $line; print FILE14 "$line\n"; }
	if ($biosample_cat eq '03hr flg22' && $biosample_name eq '03hr flg22 Rep3') {  chomp $line; print FILE15 "$line\n"; }
	if ($biosample_cat eq '12hr flg22' && $biosample_name eq '12hr flg22 Rep1') {  chomp $line; print FILE16 "$line\n"; }
	if ($biosample_cat eq '12hr flg22' && $biosample_name eq '12hr flg22 Rep2') {  chomp $line; print FILE17 "$line\n"; }
	if ($biosample_cat eq '12hr flg22' && $biosample_name eq '12hr flg22 Rep3') {  chomp $line; print FILE18 "$line\n"; }
}
