#!/bin/bash
#call helpers script to determine what db should be emptied.
bash /OS1-Project/Scripts/helpers/chooseDB.bash 3
if [ $? -ne 0 ];then
	echo Error, Error Code $?
	exit 1;
fi
#grab the dbName from the temp file.
dbName=$(< /OS1-Project/tmp/selected_db.txt)

folder_path="/OS1-Project/Databases/$dbName"
#check if there is any tables to be emptied
file_count=$(find "$folder_path" -maxdepth 1 -type f -name '*.txt' | wc -l)
if [ $file_count -eq 0 ];then
	echo no tables
	exit 1
fi
#There is!, so lets remove them
if [ -d "$folder_path" ]; then
    # Iterate over all .txt files in the folder
    for file in "$folder_path"/*.txt; do
        # Check if the file exists and is writable
        if [ -f "$file" ] && [ -w "$file" ]; then
            # Empty the file using truncate
            tmpPath="/OS1-Project/tmp/emptyDB.tmp"
            head -n 1 "$file" > "$tmpPath" && mv "$tmpPath" "$file"
        else
            echo "Skipped: $file (not a writable file)"
        fi
    done
    exit 0
else
    echo "The folder does not exist."
    exit 1
fi


