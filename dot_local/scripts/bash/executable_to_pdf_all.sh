#!/bin/bash

valid_types=(
    "docx"
    "pptx"
)

is_valid() {
    #echo "Running"
    file="$1"
    for ftype in "${valid_types[@]}"; do
        #echo "Checking $ftype"
        if [[ $file == *.${ftype} ]]; then
            return 0
            #return "true";
        fi
    done
    return 1
    #return false
}

dir=$1
#for file in $(ls "$dir"); do
#for file in */"$dir"; do
for file in "$dir"/*; do
    echo "$file"
    #if [[ $(is_valid "$file") == "true" ]]; then 
    #validity=$(is_valid "$file")
    #if [[ $(is_valid "$file") == 0 ]]; then 
    #if [[ $validity == 0 ]]; then 
    #if [[ `is_valid "$file"` == 0 ]]; then
    is_valid "$file"
    if [[ $? == 0 ]]; then 
        #echo "Converting: $file"
        soffice --headless --convert-to pdf "$file"
    fi
done
