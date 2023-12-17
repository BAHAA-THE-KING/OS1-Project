echo "What is the DB Name?"
read -r name
#TODO:Is there an existing database
echo "Is it Public?(y or n)"
read -r isPublic
#TODO:check that he entered y or n and not something else
mkdir -p ../Databases/$name
if [ "$isPublic" = "y" ]; then
chmod o=rw ../Databases/$name;
else
chmod o-rx ../Databases/$name;
fi
sudo groupadd $name
sudo usermod -a -G $name $(whoami)

while IFS= read -r admin; do
  sudo usermod -a -G $name $admin
done < "../admins.txt"

metadatapath="../Databases/$name/$name.config"
touch $metadatapath
if [ "$isPublic" = "y" ]; then
echo "public" >> $metadatapath
else
echo "private" >> $metadatapath
fi
echo "owner=$(whoami)" >> $metadatapath 
