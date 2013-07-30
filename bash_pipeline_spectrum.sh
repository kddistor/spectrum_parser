#!/bin/bash
#Spectrum Parser Bash pipeline
#Specify Threshhold
peptideThresh=90
xtanThresh=1
#Specify input file
spectrum_file=Spectrumfiltered.txt
#Specify output file
spectrum_file_output=final.txt
perl reportspectrum_splitter.pl $spectrum_file
for FILE in *.text
do
perl scancountfull_parser.pl $FILE $FILE.out $FILE.out.final $peptideThresh $xtanThresh
done
perl reportspectrum_merger.pl $spectrum_file_output
perl ratio_generator.pl 10minflg22_rep1.text.out.final 10minH2O_rep1.text.out.final A10.ratio
perl ratio_generator.pl 10minflg22_rep2.text.out.final 10minH2O_rep2.text.out.final B10.ratio
perl ratio_generator.pl 10minflg22_rep3.text.out.final 10minH2O_rep3.text.out.final C10.ratio
perl ratio_generator.pl 03hrflg22_rep1.text.out.final 03hrH2O_rep1.text.out.final A03.ratio
perl ratio_generator.pl 03hrflg22_rep2.text.out.final 03hrH2O_rep2.text.out.final B03.ratio
perl ratio_generator.pl 03hrflg22_rep3.text.out.final 03hrH2O_rep3.text.out.final C03.ratio
perl ratio_generator.pl 12hrflg22_rep1.text.out.final 12hrH2O_rep1.text.out.final A12.ratio
perl ratio_generator.pl 12hrflg22_rep2.text.out.final 12hrH2O_rep2.text.out.final B12.ratio
perl ratio_generator.pl 12hrflg22_rep3.text.out.final 12hrH2O_rep3.text.out.final C12.ratio
perl experiment_concatenator.pl A10.ratio B10.ratio C10.ratio 10min.txt
perl experiment_concatenator.pl A03.ratio B03.ratio C03.ratio 03hrs.txt
perl experiment_concatenator.pl A12.ratio B12.ratio C12.ratio 12hrs.txt
#remove files that aren't the final files
for FILE in *.text
do
rm $FILE
done
for FILE in *.out
do
rm $FILE
done
# for FILE in *.final
# do
# rm $FILE
# done
