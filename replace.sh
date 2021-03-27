#!/bin/bash
# Small script that replaces \\ with a single \ 
FILES=$(find ./ -type f -name '*')
for file in $FILES; do
   sed -i -e 's/\/\/\/\//\//g' $file
done
