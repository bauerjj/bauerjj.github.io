#!/bin/sh
# Small script that replaces \\ with a single \ 
for file in *; do
 if [ ${file: -5} == ".html" ]; then
	sed -i -e 's/\/\//\//g'
 fi
done
