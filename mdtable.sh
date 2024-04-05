#!/bin/bash

FILE=$1
COL_COUNT=$2
PREFIX='frag'

TABLE="mdtable.md"
> "$TABLE"

if [[ $1 == "-h" ]]; then
    echo "mdtable - Text-to-MD-Table script"
    echo ""
    echo "Usage: ./mdtable.sh [text-file] [column-count]"
    echo ""
    echo "  text-file
        path to text that is going to be transformed"
    echo ""
    echo "  column-count
        value that divides the text into <column-count> columns in the table"
    echo ""
    exit 1
fi

if [[ ! -f "$FILE" ]]; then
    echo "The file $FILE does not exist. Please check for any spelling errors, or use ./mdtable.sh -h for help."
    exit 1
fi

if [[ ! $(file $FILE --mime-type | grep "text/plain") ]]; then
    echo "The file $FILE is not a .txt file. Please convert it to the correct format."
    exit 1
fi

LINE_DELIM=$(wc -l $1 | cut -d ' ' -f1)
LINE_DELIM=$(((LINE_DELIM + 1) / COL_COUNT))

split -l "$LINE_DELIM" "$FILE" "$PREFIX" -d -a 1
sed -i '2s/^/:---:\n/' "$PREFIX"*
sed -i 's/^/| /' "$PREFIX"*

paste -d " " "$PREFIX"* >> "$TABLE"
sed -i 's/$/ |/' "$TABLE"

rm $PREFIX*

echo "Done!"
