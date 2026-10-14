#!/bin/bash

csv_filepath="$1"
named_heading="$2"
number_rows="$3"

if [ -z "$csv_filepath" ]; then
    echo "You must provide a CSV file path"
    exit 1
fi

if [ -z "$named_heading" ]; then
    echo "You must provide a heading"
    exit 1
fi

header=$(head -n 1 "$csv_filepath")
column_number=$(echo "$header" | tr ',' '\n' | nl -w1 -s' ' | grep "$named_heading" | cut -d' ' -f1)

if [ -z "$column_number" ]; then
    echo "Heading '$named_heading' not found in CSV file"
    exit 1
fi

if [ -z "$number_rows" ]; then
    echo "$header"
    tail -n +2 "$csv_filepath" | sort -t ',' -k"$column_number" -r
else
    echo "$header"
    tail -n +2 "$csv_filepath" | sort -t ',' -k"$column_number" -r | head -n "$number_rows"
fi
