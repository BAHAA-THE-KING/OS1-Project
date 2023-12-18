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


