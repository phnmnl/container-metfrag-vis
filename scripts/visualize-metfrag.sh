#!/bin/bash
csvfiles=$1   		# comma separated list of MetFrag csv files
outputfile=$2		# output file (pdf)
parameterfiles=$3	# file containing commandline parameters used to generate files
# add header to output file
for i in $(echo $csvfiles | tr ',' '\n')
do
	head -n 1 $i
done | head -n 1 > $outputfile
fileindex=0
if [ ! -z ${parameterfiles+x} ]							# add url strings to result files if set
then 
	echo "here"
	IFS=',' read -a paramArray <<< "$parameterfiles"
	sed -i "s/$/,\"SampleName\",\"MetFragWebURL\"/" $outputfile		# add additional columns
	for i in $(echo $csvfiles | tr ',' '\n') 
	do
		line=$(cat ${paramArray[${fileindex}]})
		if [ "$(wc -l $i | cut -d" " -f1)" -ne "0" ]			# only add parameters if csv file has entries
		then
			# convert the parameters 
			sampleName=$(echo $line | sed "s/.*SampleName\s*=\s*//" | sed "s/\s.*//")		# get SampleName
			url="http://msbi.ipb-halle.de/MetFragBeta/landing.xhtml?$(echo $line | sed 's/\s\+/\\\&/g' | sed 's/_/\\\_/g')"
			echo "$(head -n 2 $i | tail -n 1),\"${sampleName}\",\"$url\"" >> $outputfile			
			# to check
			# FragmentPeakMatchAbsoluteMassDeviation, FragmentPeakMatchRelativeMassDeviation, DatabaseSearchRelativeMassDeviation, PrecursorCompoundIDs, IonizedPrecursorMass, NeutralPrecursorMass, NeutralPrecursorMolecularFormula, PrecursorIonMode, PeakList, IonizedPrecursorMass, MetFragDatabaseType


		fi
		fileindex=$((fileindex+1))
	done
else									       # just get first result entry
	for i in $(echo $csvfiles | tr ',' '\n')
        do
               	if [ "$(wc -l $i | cut -d" " -f1)" -ne "0" ]                   # if file is not empty
               	then
               	        # convert the parameters 
                       	head -n 2 $i | tail -n 1 >> $outputfile                    
               	fi
	done
fi
