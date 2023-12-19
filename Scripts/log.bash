#!/bin/bash
sudo mkdir -p /opt/logs/


# Log file path
log_dir="/opt/logs"
user_type="others"

db_path="/OS1-Project/Databases/$2"
if cat /OS1-Project/admins.txt | grep -q $(whoami); then
user_type="admin"
fi
if cat $db_path/$2.config | grep -q "owner: $(whoami)"; then
user_type="owner"
fi

    operation=$1
    db_name=$2
    user=$(whoami)
    date=$(date)
    
    echo "$operation: $db_name: $user: $user_type: $date" >> "$log_dir/logs.txt"

    # 0 0 * * * bash rotate_logs.bash



### we did a chmod 777 on log directory