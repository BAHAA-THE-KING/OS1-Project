#!/bin/bash

#chooseDB
bash /OS1-Project/Scripts/helpers/chooseDB.bash 8
dbName=$(</OS1-Project/tmp/selected_db.txt)
#chooseTable
bash /OS1-Project/Scripts/helpers/choose_table.bash $dbName
tableName=$(</OS1-Project/tmp/selected_table.txt)
#chooseColumn
data_file="/OS1-Project/Databases/$dbName/$tableName.txt"
IFS=',' read -r -a columns < <(head -n 1 "$data_file")
while true; do
    # Print column numbers and names
    for ((i = 0; i < ${#columns[@]}; i++)); do
        echo "$((i + 1)) - ${columns[i]}"
    done

    # Prompt user to choose a column
    read -p "Choose a column : " column_number

    # Validate user input
    if [[ ! "$column_number" =~ ^[1-${#columns[@]}]$ ]]; then
        echo "Invalid input. Please choose a number between 1 and ${#columns[@]}."
    else
        # Get the chosen column name
        # ((column_number--))
        chosen_column="${columns[$((column_number))]}"
        break  # Exit the loop if input is valid
    fi
done

#chooseRow by id
read -p "Enter row ID: " rowId

#insert new value
read -p "Enter New Value:" newValue


#update it
# Validate column_number and rowId
# Validate rowId
if [ "$rowId" -le 0 ] || ! grep -qE "^$rowId," "$data_file"; then
    echo "Invalid row id."
    exit 1
fi
# Update the value in the specified row
awk -F',' -v row="$rowId" -v col="$column_number" -v newVal="$newValue" 'BEGIN{OFS=","} $1==row {$col=newVal} {print}' "$data_file" > "/OS1-Project/tmp/updateData.tmp" && mv "/OS1-Project/tmp/updateData.tmp" "$data_file"

# Display the updated data
echo "Updated data:"
awk -F',' -v row="$rowId" '$1==row {print}' "$data_file"

bash log.bash "update" $dbName