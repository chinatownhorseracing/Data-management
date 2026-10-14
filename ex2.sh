#!/bin/bash

csv_filepath="$1"
csv_noduplicate_filepath="$2"

header=$(head -n 1 "$csv_filepath")

if [ -z "$csv_noduplicate_filepath" ]; then
    tempfile="temp.csv"
    echo "$header" > "$tempfile"
    tail -n +2 "$csv_filepath" | sort | uniq >> "$tempfile"
    mv "$tempfile" "$csv_filepath"
else
    echo "$header" > "$csv_noduplicate_filepath"
    tail -n +2 "$csv_filepath" | sort | uniq >> "$csv_noduplicate_filepath"
fi