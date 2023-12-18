#!/bin/bash
source ~/OS1-Project/project_init.sh
dbName=$1
table_name=$2

get_columns() {
    metadataPath="$DATABASES_PATH/$dbName/$dbName.config";
    line=$(grep $table_name $metadataPath);
    IFS='=' read -r -a columns <<< "${line#*=}"
    #columns=$(awk -F':' -v table="$table_name"  '$1 ~ table && NF > 1 {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}' "$metadataPath")
    echo "$columns"
}
columns=$(get_columns)
if [ -n "$columns" ]; then
    echo "Columns of $table_name: $columns"
else
    echo "Table not found."
fi

data_file="$DATABASES_PATH/$dbName/$table_name.txt"


# Check if the file exists
if [ ! -f "$data_file" ]; then
    echo "Error: File not found."
    exit 1
fi

# Print table header with dynamically adjusted column widths
printf "| %-10s " "${columns[@]}"
echo "|"

# Print separator line
separator_line=$(printf "|%*s|" $((${#columns[@]} * 12)) "")
echo "${separator_line// /-}"

# Read each line and print data rows
while IFS= read -r line; do
    # Split the line into values using ',' as the delimiter
    IFS=',' read -r -a values <<< "$line"
	printf "| %-10s " "${values[@]}"
        echo "|"
    
    
done < "$data_file"
