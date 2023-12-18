#!/bin/bash

dbName="popopopo"

is_positive_integer() {
    re='^[0-9]+$'
    if ! [[ $1 =~ $re ]] || [ "$1" -lt 1 ]; then
        return 1
    else
        return 0
    fi

}
# Ask the user for the table name
read -p "Enter the table name: " table_name

# Ask the user for the column count
read -p "Enter the number of columns: " column_count

# Validate the input
if ! is_positive_integer "$column_count"; then
    echo "Invalid input. Please enter a positive integer greater than 0."
    exit 1
fi

# Initialize an array to store column names
column_names=()
column_names+=("id")
# Loop to ask the user for each column name
for ((i = 1; i <= column_count; i++)); do
    read -p "Enter the name of column $i: " column_name
    # Add the column name to the array
    column_names+=("$column_name")
done

# Join the array elements into a comma-separated string
column_names_csv=$(IFS=,; echo "${column_names[*]}")

touch /OS1-Project/Databases/$dbName/$table_name.txt;
echo "$table_name: $column_names_csv" >>/OS1-Project/Databases/$dbName/$dbName.config

ehco $column_names_csv > /OS1-Project/Databases/$dbName/$table_name.txt