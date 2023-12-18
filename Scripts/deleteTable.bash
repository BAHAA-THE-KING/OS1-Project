#!/bin/bash
sh helpers/UserCanEditDB.sh "$dbName"

if [ $? -eq 0 ]; then
    # Add your commands here if the condition is true
    :
else
    echo "Unallowed user!"
    exit 1
fi


bash helpers/chooseDB.bash 5

# Specify the file path
db="/OS1-Project/tmp/selected_db.txt"

# Check if the file exists
if [ -e "$db" ]; then
    # Read the content of the file into a variable
    db_content=$(<"$db")

    # Display the content of the variable
    # echo "File Content:"
    # echo "$db_content"
    bash helpers/choose_table.bash $db_content


    

else
    echo "File '$db' not found."
fi