#!/bin/sh

#!/bin/sh
[ -z "$1" ] && echo "Give either a pdf file or a DOI as an argument." && exit

if [ -f "$1" ]; then
	# Try to get DOI from pdfinfo or pdftotext output.
	doi=$(pdfinfo "$1" | grep -io "doi:.*") ||
	doi=$(pdftotext "$1" 2>/dev/null - | grep -io "doi.*" -m 1) ||
	echo "doi not found for $1" 
else
	doi="$1"
fi

# Check crossref.org for the bib citation.
curl -s "https://api.crossref.org/works/$doi/transform/application/x-bibtex" -w "\\n" || echo "doi not found for $1"