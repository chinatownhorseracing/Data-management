#!/bin/bash

url="$1"
filepath="$2"
tempfile="temp.csv"

if [ -z "$filepath" ]; then
    curl -o "$tempfile" "$url"

    awk '{
    quote_count += gsub(/"/, "&");
    if (quote_count % 2 == 1) {
        printf "%s ", $0;
    } else {
        print $0;
    }
}' "$tempfile" > "fix_broken_rows.csv"

    head "fix_broken_rows.csv"
    rm "fix_broken_rows.csv"
    rm "$tempfile"

else
    curl -o "$tempfile" "$url"
    
    awk '{
    quote_count += gsub(/"/, "&");
    if (quote_count % 2 == 1) {
        printf "%s ", $0;
    } else {
        print $0;
    }
}' "$tempfile" > "$filepath"
    rm "$tempfile"
fi