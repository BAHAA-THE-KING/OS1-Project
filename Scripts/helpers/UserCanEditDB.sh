#!/bin/bash
source ~/OS1-Project/project_init.sh
if [ "$#" -ne 1 ]; then
    echo "Error: DB name argument required."
    exit 1
fi

dbName=$1;
user=$(whoami)

if getent group $dbName | grep -qw "$user"; then
    exit 0
else
    exit 1
fi

