#!/usr/bin/perl
###############################
#Spectrum Report Parser       #
#File Merger  			  #
#by Kevin Distor              #
###############################


use strict;
use warnings;

# die "<OUTFILE>" unless @ARGV==1;

my $outfile = $ARGV[0];

open (MERGED, ">$outfile") or die 'File cannot be opened\n\n';
open FILE1, "<10minH2O_rep1.text.out.final" or die 'File cannot be opened\n\n';
open FILE2, "<10minH2O_rep2.text.out.final" or die 'File cannot be opened\n\n';
open FILE3, "<10minH2O_rep3.text.out.final" or die 'File cannot be opened\n\n';
open FILE4, "<03hrH2O_rep1.text.out.final" or die 'File cannot be opened\n\n';
open FILE5, "<03hrH2O_rep2.text.out.final" or die 'File cannot be opened\n\n';
open FILE6, "<03hrH2O_rep3.text.out.final" or die 'File cannot be opened\n\n';
open FILE7, "<12hrH2O_rep1.text.out.final" or die 'File cannot be opened\n\n';
open FILE8, "<12hrH2O_rep2.text.out.final" or die 'File cannot be opened\n\n';
open FILE9, "<12hrH2O_rep3.text.out.final" or die 'File cannot be opened\n\n';
open FILE10, "<10minflg22_rep1.text.out.final" or die 'File cannot be opened\n\n';
open FILE11, "<10minflg22_rep2.text.out.final" or die 'File cannot be opened\n\n';
open FILE12, "<10minflg22_rep3.text.out.final" or die 'File cannot be opened\n\n';
open FILE13, "<03hrflg22_rep1.text.out.final" or die 'File cannot be opened\n\n';
open FILE14, "<03hrflg22_rep2.text.out.final" or die 'File cannot be opened\n\n';
open FILE15, "<03hrflg22_rep3.text.out.final" or die 'File cannot be opened\n\n';
open FILE16, "<12hrflg22_rep1.text.out.final" or die 'File cannot be opened\n\n';
open FILE17, "<12hrflg22_rep2.text.out.final" or die 'File cannot be opened\n\n';
open FILE18, "<12hrflg22_rep3.text.out.final" or die 'File cannot be opened\n\n';

my $firstline = <FILE1>;
print MERGED "$firstline";

while (<FILE1>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n";}
while (<FILE2>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE3>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE4>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE5>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE6>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE7>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE8>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE9>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE10>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE11>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE12>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE13>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE14>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE15>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE16>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE17>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
while (<FILE18>) {chomp; next if $_=~m/peptide/; print MERGED "$_\n" unless $_=~m/^$/;}
