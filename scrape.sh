#!/bin/bash

# Check for path argument.
if [ $# -ne 1 ]
then
    echo "Invalid arguments."
    echo -e "Usage: ./scrape.sh REPORT-DIRECTORY/"
    exit 1
fi




# Recursive walk on directory.
# Extract plain text from docx file.
    # Use: unzip -p some.docx word/document.xml | sed -e 's/<[^>]\{1,\}>//g; s/[^[:print:]]\{1,\}//g'
# Filter IOCs using various regexs.