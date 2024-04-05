#!/bin/bash

input_file=$1
column_count=$2
temp_prefix='frag'

table_file="mdtable.md"
> "$table_file"

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

if [[ ! -f "$input_file" ]]; then
    echo "The file $input_file does not exist. Please check for any spelling errors, or use ./mdtable.sh -h for help."
    exit 1
fi

if [[ ! $(file $input_file --mime-type | grep "text/plain") ]]; then
    echo "The file $input_file is not a .txt file. Please convert it to the correct format."
    exit 1
fi

line_count=$(wc -l $1 | cut -d ' ' -f1)
line_count=$(((line_count + 1) / column_count))

split -l "$line_count" "$input_file" "$temp_prefix" -d -a 1
sed -i '2s/^/:---:\n/' "$temp_prefix"*
sed -i 's/^/| /' "$temp_prefix"*

paste -d " " "$temp_prefix"* >> "$table_file"
sed -i 's/$/ |/' "$table_file"

rm $temp_prefix*

echo "Done!"
