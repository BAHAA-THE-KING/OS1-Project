#!/bin/bash

echo -e you can insert data into these DBs:
echo --------------------------------------

bash helpers/chooseDB.bash 6
if [ $? -ne 0 ];then
	echo Error, Error Code $?
	exit 1;
fi

db_name="/OS1-Project/tmp/selected_db.txt"
db=$(<$db_name)
db_dir="../Databases/$db"

echo -e "Tables:\n ---->"

bash helpers/choose_table.bash $db
table_name="/OS1-Project/tmp/selected_Table.txt"
table=$(<$table_name)

tb=$(cat ../Databases/$db/$db.config | grep $table )

columns=$(echo "$tb" | awk -F': id' '{print $2}' | tr ',' '\n')

last_id=$(tail -n 1 $db_dir/$table.txt | cut -d',' -f1)
id=$(($last_id+1))

row=$id,

echo -e "enter data: \n------>"
for column in ${columns[@]}
do
	echo  $column:
	read data
	row+=$data,
done
echo ${row%?} >> ../Databases/$db/$table.txt

echo row added successfully with id: $id.



# Assuming log.bash is in the same directory
bash log.bash "insert" $db

