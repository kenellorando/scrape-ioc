# scrape-ioc
Scraper script for doc and docx files, pulls probable indicators of compromise including:
- IP address
- Email address
- MD5 hashes
- SHA256 hashes
- Potentially malicious filenames (by extension)

## Usage
```
./scrape.sh DOC
# Where DOC is a doc/docx file or a directory containing doc/docx files.
```
