#!/bin/bash

valid_types=(
    "docx"
    "pptx"
)

is_valid() {
    file="$1"
    for ftype in "${valid_types[@]}"; do
        if [[ $file == *.${ftype} ]]; then
            return 0
        fi
    done
    return 1
}

dir=$1
for file in "$dir"/*; do
    echo "$file"
    is_valid "$file"
    if [[ $? == 0 ]]; then 
        soffice --headless --convert-to pdf "$file"
    fi
done
