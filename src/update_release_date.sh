#!/bin/zsh

# Pass in starting dir as argument to script
START_DIR=${1:-.}

# Set default content create date
DEFAULT_CREATE_DATE="1969-12-31 05:00:00Z"

# Find all .mp4 files recursively starting from START_DIR
find "$START_DIR" -type f -name '*.mp4' | while read -r file; do
    # Check if the file already has a "Content Create Date" tag
    CREATE_DATE=$(exiftool -b -ContentCreateDate "$file")
    
    # If the "Content Create Date" tag does not exist, is empty, is "na" or "0", update it
    # Could only update create date when existing field is null or not a valid date (is_valid_date)
    if [ -z "$CREATE_DATE" ] || [ "$CREATE_DATE" = "na" ] || [ "$CREATE_DATE" = "0" ]; then
        echo "Updating Content Create Date for file: $file"
        exiftool -ContentCreateDate="$DEFAULT_CREATE_DATE" "$file" # may want -overwrite_original flag
    fi
done


# is_valid_date() {
#     date -d "$1" > /dev/null 2>&1
#     return $?
# }
