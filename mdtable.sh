#!/bin/bash

FILE=$1         #file passed as an argument
COL_COUNT=$2    #column count passed as an argument
PREFIX='frag'   #temporary files prefix to concatenate later

TABLE="mdtable.md"  #create md file
> "$TABLE"          #clear it

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

if ! file --mime-type "$FILE" | grep -q txt$; then
    echo "The file $FILE is not a .txt file. Please convert it to the correct format."
    exit 1
fi

LINE_DELIM=$(wc -l $1 | cut -d ' ' -f1)         #get line count
LINE_DELIM=$(((LINE_DELIM + 1) / COL_COUNT))    #+1 cause it returns line-1, and divide by column count to separate each column

echo "Splitting columns..."
split -l "$LINE_DELIM" "$FILE" "$PREFIX" -d -a 1
echo "Concatenating columns..."
paste -d " " "$PREFIX"* >> "mdtable.md"
echo "Removing temporary files..."
rm $PREFIX*
echo "Done!"
#echo $(pr $FILE -$COL_COUNT -t) > $FILE

#echo $(awk 'BEGIN { FS="\n"; } { print $1; }' $FILE)
