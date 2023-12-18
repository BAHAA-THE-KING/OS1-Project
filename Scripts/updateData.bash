#!/bin/bash

#chooseDB
bash /OS1-Project/Scripts/chooseDB.bash 8
dbName=$(</OS1-Project/tmp/selected_db.txt)

#chooseTable
bash /OS1-Project/Scripts/choose_table.bash dbName
tableName=$(</OS1-Project/tmp/selected_table.txt)

#chooseColumn

#chooseRow by id
echo "Enter Row ID:"
read rowID

#insert new value
echo "Enter New Value:"
read newValue

#update it
