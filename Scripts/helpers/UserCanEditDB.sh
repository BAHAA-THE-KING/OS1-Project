#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "Error: DB name argument required."
    exit 1
fi

dbName=$1;
user=$(whoami)

if getent group $dbName | grep -qw "$user"; then
    echo y
else
    echo n
fi

