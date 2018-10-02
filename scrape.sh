#!/bin/bash

# Check for path argument.
if [ $# -ne 1 ]
then
    echo "Invalid arguments."
    echo -e "Usage: ./scrape.sh REPORT-DIRECTORY/"
    exit 1
fi

# Find all .doc/.docx files.
find $1 -type f -name "*.doc" -o -name "*.docx" | while read file; do
    echo $file
    # Extract the plaintext of the document
    unzip -p $file word/document.xml | sed -e 's/<\/w:p>/\n/g; s/<[^>]\{1,\}>//g; s/[^[:print:]\n]\{1,\}//g'
done

# Filter IOCs using various regexs.