#!/bin/bash
if (!(cat /OS1-Project/owners.txt | grep -q $(whoami)) && !(cat /OS1-Project/admins.txt | grep -q $(whoami))) ; then
echo "You cannot access logs!!!"
else
cat /opt/logs/logs.txt
fi






