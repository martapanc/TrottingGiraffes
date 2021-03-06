#!/bin/bash

#Sets the output directory to reports and the file name to the first argument (<outputFileName>)
OUTPUTFILE=../reports/$1
#Sets the CONTENT variable to the second argument (<folderToConvert>)
CONTENT=$2

#Ensures the output file exists and has write permissions
touch $OUTPUTFILE
chmod +rwx $OUTPUTFILE

#Add css styling header for table
echo "<!DOCTYPE html>" > $OUTPUTFILE
echo "<html lang=\"en\">" >> $OUTPUTFILE
echo " <head>" >> $OUTPUTFILE
echo "<style type=\"text/css\">" >> $OUTPUTFILE
echo ".tg  {border-collapse:collapse;border-spacing:0;}" >> $OUTPUTFILE
echo ".tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}" >> $OUTPUTFILE
echo ".tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}" >> $OUTPUTFILE
echo ".tg .tg-yw4l{vertical-align:top}" >> $OUTPUTFILE
echo "</style>" >> $OUTPUTFILE
echo "<table class=\"tg\">" >> $OUTPUTFILE
echo "<tr>" >> $OUTPUTFILE

#Add table column headers
echo "  <th class=\"tg-yw4l\">Test Number</th>" >> $OUTPUTFILE
echo "  <th class=\"tg-yw4l\">Class</th>" >> $OUTPUTFILE
echo "  <th class=\"tg-yw4l\">Method</th>" >> $OUTPUTFILE
echo "  <th class=\"tg-yw4l\">Requirement</th>" >> $OUTPUTFILE
echo "  <th class=\"tg-yw4l\">Input</th>" >> $OUTPUTFILE
echo "  <th class=\"tg-yw4l\">Output</th>" >> $OUTPUTFILE
echo "  <th class=\"tg-yw4l\">Oracle</th>" >> $OUTPUTFILE
echo "  <th class=\"tg-yw4l\">Result</th>" >> $OUTPUTFILE
echo "</tr>" >> $OUTPUTFILE




#Runs ls command on the results folder, which contains the individual results of each method test.
#Adds the results to the table as it iterates.
COUNTER=1
ls $CONTENT | while read FILENAME 
do

	#For unknown reasons, the first row in the table ends up with the css content from the echo command above instead of the actual content of the folder.
	#This is a safeguard against that.
	if [ $COUNTER -ne 1 ]
	then

	BUGFIX=$[COUNTER-1]
	echo "<tr>" >> $OUTPUTFILE

	echo "<td class=\"tg-yw4l\">$BUGFIX</td>" >> $OUTPUTFILE
	LINECOUNT=0
	cat $CONTENT/$FILENAME | while read line
	do 
			LINECOUNT=$[LINECOUNT+1]
		
			a=($line)
			CLASSNAME="${a[0]}"
			METHODNAME="${a[1]}"
			INPUTARG="${a[2]}"
			OUTPUTARG="${a[3]}"
			ORACLEARG="${a[4]}"
			PASSFAIL="${a[5]}"

			a1="<td class=\"tg-yw4l\">$CLASSNAME"
			a2="</td>"
			echo "$a1$a2" >> $OUTPUTFILE

			b1="<td class=\"tg-yw4l\">$METHODNAME"
			b2="</td>"
			echo "$b1$b2" >> $OUTPUTFILE

			#GET REQUIREMENT
			CASENUMBER=$[COUNTER-1]
			if [ $CASENUMBER -lt 10 ]
			then
			
			TESTCASECOUNTER=1
			cat ../testCases/testCase0$CASENUMBER.txt | while read testCaseLine
			do 
				if [ $TESTCASECOUNTER -eq 2 ]
				then 

					#Get length of line string for formatting
					TESTCASESLINELENGTH=${#testCaseLine}

					#Remove numbers at beginning of lines
					#For instance, if the line says 1. Hello, this will return Hello
					TESTCASESLINECHOPPED="${testCaseLine:3:$TESTCASESLINELENGTH}"
		
					#Deletes any comments within the test case files, marked by ## (double hash)
					#Get position of double hash character (##)
					#Thanks to modified responses to:
					#http://stackoverflow.com/questions/20348097/bash-extract-string-before-a-colon 
		
					CHARPOS=$(echo $TESTCASESLINECHOPPED | grep -b -o "##" | cut -d: -f1)
		

					#Get substring of the line with comment removed
					CHOPPED=${TESTCASESLINECHOPPED:0:$CHARPOS}


					buildRequirementRowp1="<td class=\"tg-yw4l\">$CHOPPED"
					buildRequirementRowp2="</td>"
					echo "$buildRequirementRowp1$buildRequirementRowp2" >> $OUTPUTFILE

				fi
				TESTCASECOUNTER=$[TESTCASECOUNTER+1]
			
			done

			fi

			if [ $CASENUMBER -gt 9 ]
			then
			TESTCASECOUNTER=1
			cat ../testCases/testCase$CASENUMBER.txt | while read testCaseLine
			do 
				if [ $TESTCASECOUNTER -eq 2 ]
				then 
					#Get length of line string for formatting
					TESTCASESLINELENGTH=${#testCaseLine}

					#Remove numbers at beginning of lines
					#For instance, if the line says 1. Hello, this will return Hello
					TESTCASESLINECHOPPED="${testCaseLine:3:$TESTCASESLINELENGTH}"
		
					#Deletes any comments within the test case files, marked by ## (double hash)
					#Get position of double hash character (##)
					#Thanks to modified responses to:
					#http://stackoverflow.com/questions/20348097/bash-extract-string-before-a-colon 
		
					CHARPOS=$(echo $TESTCASESLINECHOPPED | grep -b -o "##" | cut -d: -f1)
		

					#Get substring of the line with comment removed
					CHOPPED=${TESTCASESLINECHOPPED:0:$CHARPOS}


					buildRequirementRowp1="<td class=\"tg-yw4l\">$CHOPPED"
					buildRequirementRowp2="</td>"
					echo "$buildRequirementRowp1$buildRequirementRowp2" >> $OUTPUTFILE

				fi
				TESTCASECOUNTER=$[TESTCASECOUNTER+1]
			
			done


			fi

			c1="<td class=\"tg-yw4l\">$INPUTARG"
			c2="</td>"
			echo "$c1$c2" >> $OUTPUTFILE

			h1="<td class=\"tg-yw4l\">$OUTPUTARG"
			h2="</td>"
			echo "$h1$h2" >> $OUTPUTFILE

			d1="<td class=\"tg-yw4l\">$ORACLEARG"
			d2="</td>"
			echo "$d1$d2" >> $OUTPUTFILE

			e1="<td class=\"tg-yw4l\">$PASSFAIL"
			e2="</td>"
			echo "$e1$e2" >> $OUTPUTFILE

		echo "</tr>" >> $OUTPUTFILE

	done

	fi

	COUNTER=$[COUNTER+1]

done

#Close table
echo "</table>" >> $OUTPUTFILE



