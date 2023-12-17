# Other scripts
source ~/OS1-Project/project_init.sh
echo "What is the DB Name?"
read -r name
#TODO:Is there an existing database
echo "Is it Public?(y or n)"
read -r isPublic
#TODO:check that he entered y or n and not something else

mkdir -p $DATABASES_PATH/$name
if [ "$isPublic" = "y" ]; then
chmod o=rw $DATABASES_PATH/$name;
else
chmod o-rx $DATABASES_PATH/$name;
fi
sudo groupadd $name
sudo usermod -a -G $name $(whoami)

while IFS= read -r admin; do
  sudo usermod -a -G $name $admin
done < $ADMINS_PATH

metadatapath="$DATABASES_PATH/$name/$name.config"
touch $metadatapath
if [ "$isPublic" = "y" ]; then
echo "public" >> $metadatapath
else
echo "private" >> $metadatapath
fi
echo "owner=$(whoami)" >> $metadatapath 
