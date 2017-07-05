#!/bin/bash

# retrieve test case files
mkdir /tmp/testfiles
wget -O /tmp/testfiles/zipped-parameter-collection-data.zip https://github.com/phnmnl/container-metfrag-vis/raw/develop/testfiles/zipped-parameter-collection-data.zip
wget -O /tmp/testfiles/zipped-result-collection-data.zip https://github.com/phnmnl/container-metfrag-vis/raw/develop/testfiles/zipped-result-collection-data.zip

# prepare test files
mkdir /tmp/testfiles/results
mkdir /tmp/testfiles/parameters

unzip -j /tmp/testfiles/zipped-parameter-collection-data.zip -d /tmp/testfiles/parameters
unzip -j /tmp/testfiles/zipped-result-collection-data.zip -d /tmp/testfiles/results

input_results=$(find /tmp/testfiles/results/ -type f | tr '\n' ',' | sed "s/,$//")
input_parameters=$(find /tmp/testfiles/parameters/ -type f | tr '\n' ',' | sed "s/,$//")

# run test case
mkdir /tmp/outputdir/
bash /usr/local/bin/visualize-metfrag.sh $input_results /tmp/outputdir/combined_top1_cands.csv $input_parameters
java -jar /usr/local/bin/ConvertMetFragCSV.jar csv=/tmp/outputdir/combined_top1_cands.csv output=/tmp/outputdir/combined_top1_cands.tex propertyWhiteList=Score,SampleName,Identifier,MolecularFormula,CompoundName,NumberPeaksUsed,NoExplPeaks,MetFragWebURL format=tex
pdflatex -output-directory /tmp/outputdir/ /tmp/outputdir/combined_top1_cands.tex

# check output files
if [ ! -e /tmp/outputdir/combined_top1_cands.tex ]
then 
	echo "tex file was not created."
	exit 1
fi
if [ ! -e /tmp/outputdir/combined_top1_cands.pdf ]
then 
	echo "pdf file was not created."
	exit 1
fi

# remove all files
rm -rf /tmp/outputdir/
rm /tmp/*.png
rm -rf /tmp/testfiles/

