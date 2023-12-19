#!/bin/bash

d=$(date -d "10 days ago" "+%a %b %d")
date_todelete=$(printf '%s\n' "$d" | sed -e 's/[[\/.*&]/\\&/g')

sed -i "/$date_todelete/d" "/opt/logs/logs.txt"