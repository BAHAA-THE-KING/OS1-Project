#!/bin/bash
#todo: allow owner
if !(cat /OS1-Project/admins.txt | grep -q $(whoami)) ; then
echo "You cannot access logs!!!"
else
cat /opt/logs/logs
fi





