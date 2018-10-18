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
    # Extract the plaintext of the document out of xml
    plaintext=$(unzip -p $file word/document.xml | sed -e 's/<\/w:p>/\n/g; s/<[^>]\{1,\}>//g; s/[^[:print:]\n]\{1,\}//g')

    # Match valid IP addresses
    echo $plaintext | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"

    # Match valid email addresses
    echo $plaintext | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"

    # Match MD5 hashes
    echo $plaintext | grep -o -w "[0-9a-f]\{32\}"

    # Match SHA 256 hashes
    echo $plaintext | grep -o -w "[0-9a-f]\{64\}"
done





