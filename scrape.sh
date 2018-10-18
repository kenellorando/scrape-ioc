#!/bin/bash

# Check for path argument.
if [ $# -ne 1 ]
then
    echo "Invalid arguments."
    echo -e "Usage: ./scrape.sh DOC"
    echo -e "where `DOC` is a doc/docx file or a directory containing doc/docx files."
    exit 1
fi

# Find all .doc/.docx files.
find $1 -type f -name "*.doc" -o -name "*.docx" | while read file; do
    # Extract the plaintext of the document out of xml
    plaintext=$(unzip -p $file word/document.xml | sed -e 's/<\/w:p>/\n/g; s/<[^>]\{1,\}>//g; s/[^[:print:]\n]\{1,\}//g')

    # Match valid IP addresses
    echo $plaintext | grep -E -o -C 3 "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"

    # Match MD5 hashes
    echo $plaintext | grep -o -w "[0-9a-f]\{32\}"

    # Match SHA 256 hashes
    echo $plaintext | grep -o -w "[0-9a-f]\{64\}"

    # Match all filenames
    echo $plaintext | grep -E -o -w -i "([a-zA-Z0-9\s_\\.\-\(\):])+(.exe|.dll|.pif|.msi|.msp|.jar|.bat|.cmd|.vb|.vbs|.js|.jse|.reg|.docm|.xslm|pptm)"

    # Match valid email addresses
    # echo $plaintext | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" 

done
