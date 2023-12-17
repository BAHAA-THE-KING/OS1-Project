source ~/OS1-Project/project_init.sh
#replace this with call to bahaa's script
dbName="popopopo"


sh $HELPERS_PATH/UserCanEditDB.sh "$dbName"

if [ $? -eq 0 ]; then
    # Add your commands here if the condition is true
    :
else
    echo "Unallowed user!"
    exit 1
fi

folder_path="$DATABASES_PATH/$dbName"

if [ -d "$folder_path" ]; then
    # Iterate over all .txt files in the folder
    for file in "$folder_path"/*.txt; do
        # Check if the file exists and is writable
        if [ -f "$file" ] && [ -w "$file" ]; then
            # Empty the file using truncate
            truncate -s 0 "$file"
        else
            echo "Skipped: $file (not a writable file)"
        fi
    done
    exit 0
else
    echo "The folder does not exist."
    exit 1
fi

