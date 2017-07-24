#!/bin/bash
# Small script that replaces \\ with a single \ 
FILES=$(find ./ -type f -name '*')
for file in $FILES; do
 	#echo $file
	sed -i -e 's/\/\/\/\/\//\//g' $file
	#sed -i -e 's/https:\/\/.*\/\//https:\//g' $file
	#sed -i -e 's/https:\//https:\/\//g' $file
	#sed -i -e 's/http:\//http:\/\//g' $file
	#echo "yes"

done
