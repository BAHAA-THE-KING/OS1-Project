#!/bin/bash

# Get DB Name
bash /OS1-Project/Scripts/helpers/chooseDB.bash 5
if [ $? -ne 0 ]; then
  echo "Error, Error Code $?"
  exit 1
fi
dbName=$(< /OS1-Project/tmp/selected_db.txt)

# Run choose_table.bash with $db_name argument
bash /OS1-Project/Scripts/helpers/choose_table.bash "$dbName"
if [ $? -ne 0 ]; then
  echo "Error, Error Code $?"
  exit 1
fi
table_name=$(< /OS1-Project/tmp/selected_table.txt)

echo $table_name "tunghtrni"

metadataPath="/OS1-Project/Databases/$dbName/$dbName.config"
data_file="/OS1-Project/Databases/$dbName/$table_name.txt"

# Check if the file exists
if [ ! -f "$data_file" ]; then
    echo "Error: File not found."
    exit 1
fi

# Read the columns from the first line of the data file
IFS=',' read -r -a columns < <(head -n 1 "$data_file")

# Print table header with dynamically adjusted column widths
printf "| %-10s " "${columns[@]}"
echo "|"

# Print separator line
separator_line=$(printf "+%*s+" $((${#columns[@]} * 12 +(${#columns[@]}-1))))
echo "${separator_line// /-}"

# Use grep to filter data based on user-provided pattern
user_pattern="$1"  # Assuming the user provides the pattern as the third argument
filtered_data=$(tail -n +2 "$data_file" | grep "$user_pattern")

# Process each line in the filtered data and print rows
while IFS= read -r line; do
    # Split the line into values using ',' as the delimiter
    IFS=',' read -r -a values <<< "$line"
    printf "| %-10s " "${values[@]}"
    echo "|"
done <<< "$filtered_data"
