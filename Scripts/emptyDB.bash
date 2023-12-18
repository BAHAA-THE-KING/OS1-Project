#!/bin/bash

#replace this with call to bahaa's script
bash /OS1-Project/Scripts/helpers/chooseDB.bash 3
if [ $? -ne 0 ];then
	echo Error, Error Code $?
	exit 1;
fi

dbName=$(< /OS1-Project/tmp/selected_db.txt)

folder_path="/OS1-Project/Databases/$dbName"

file_count=$(find "$folder_path" -maxdepth 1 -type f -name '*.txt' | wc -l)
if [ $file_count -eq 0 ];then
	echo no tables
	exit 1
fi

if [ -d "$folder_path" ]; then
    # Iterate over all .txt files in the folder
    for file in "$folder_path"/*.txt; do
        # Check if the file exists and is writable
        if [ -f "$file" ] && [ -w "$file" ]; then
            # Empty the file using truncate
            truncate -s 0 "$file"
        else
            echo "Skipped: $file (not a writable file)"
        fi
    done
    exit 0
else
    echo "The folder does not exist."
    exit 1
fi

