#READ_ME - SpectrumReportParser
#by Kevin Distor

#############################################################################################################
#  This script takes in the spectrum report file (in .txt tab delimited format) and parses out				#		
#	the file to return lines that meet user inputed criterias (Peptide Probability and 						#
#	X!Tandem Score threshholds). This script also collapses the file on a line by line basis				#
#	based on similar peptide sequences and scan number. First, lines with similar scan numbers will be 		#
#	collapsed onto to the line which first had that scan. Peptide sequences from the collapsed lines 		#
#	will be moved to the end of the first line and separated with individually tabs. Second, lines with		#
#	similar peptide sequences will be collapsed onto the the line which first had that sequence. Scan 		#
#	numbers from the collapsed lines will be moved to the end of the first line and separated with 			#
#	individually tabs. 																						#
#############################################################################################################

Scripts: 
1. reportspectrum_splitter.pl		#splits file into different treatment, time period, replicates. 18 total
2. scannum_parser.pl				#collapses lines of output from 1. by scan number
3. peptideseq_parser.pl				#collapses lines of output from 2. by peptide sequence
5. scancountfull_parser.pl			#combination of 2 and 3 and returns scan count
6. reportspectrum_merger.pl			#merges files generated by 3. into one final table
7. bash_pipeline_spectrum.sh		#shell script to automate 1-4. This is where you input parameters and
										specify input files and output names.

Modifications to files/scripts before using:
	Input file
		Open file in Excel:
			-"Other proteins" column should not have blanks. Replace blanks with "NA" or alternative.
			-Create a column next to Other Proteins and fill with "0" with title "Scan Counter"
			-save as (.txt tab delimited format)
		Open file in Notepad++:
			-remove all instances of “controllerType=0 controllerNumber=1 scan=” from Scan Name column
			-remove all instances of "%"
			-Convert end of line to UNIX format. Open in Notepad++. Go to Edit -> EOL Conversion -> UNIX/Mac
			-save
	bash_pipeline_spectrum.sh
		line 3 - specify peptide probability threshhold
		line 4 - specify X!Tandem score threshhold
		line 5 - specify input Spectrum file
		line 6 - specify output final file
		line 22-33 - option to remove/keep the inbetween files or not.
		
Dependencies:
	-All scripts and input files have to be in the same directory.
	-Directory should be void of any .text, .out, and .final files that you don't want to be deleted

Usage: sh bash_pipeline_spectrum.sh

Default output is(shell script lines 12-19 commented out): 
	-Ouput file with scan count at the end. 
	
To ouput files with collapsed scan numbers and collapsed peptide sequences, comment out shell script lines 8-11.
	- Can modify shell script to view files in between of process. ie. files that have only lines with
		collapesd scan numbers (.out files) or files that have only lines with collapsed peptide 
		sequences (.final files) by commenting out repective lines in the shell file lines 22-33.
	- Can reverse the order of collapsing by modifying whether scannum_parser.pl or peptideseq_parser.pl
		goes first in the bash_pipeline_spectrum.sh shell script. 
