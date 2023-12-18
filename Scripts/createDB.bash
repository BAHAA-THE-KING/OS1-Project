#!/bin/bash

echo "What is the DB Name?"
read name
#TODO:Is there an existing database
echo "Is it Public?(y or n)"
read isPublic
#TODO:check that he entered y or n and not something else

mkdir -p /OS1-Project/Databases/$name
sudo groupadd $name
sudo usermod -a -G $name $(whoami)

while IFS= read -r admin; do
  sudo usermod -a -G $name $admin
done < /OS1-Project/admins.txt

metadatapath="/OS1-Project/Databases/$name/$name.config"
touch $metadatapath
if [ "$isPublic" = "y" ]; then
echo "type: public" >> $metadatapath
else
echo "type: private" >> $metadatapath
fi
echo "owner: $(whoami)" >> $metadatapath 
bash log.bash "create" $name