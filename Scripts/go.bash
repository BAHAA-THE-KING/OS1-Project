#!/bin/bash

while true; do
    # Clear the screen for a cleaner display
    clear

    echo "-----------------------------------"
    echo "       Database Management        "
    echo "-----------------------------------"
    echo "Select an option:"
    echo "  1. Create a Database"
    echo "  2. Delete a Database"
    echo "  3. Empty a Database"
    echo "  4. Create tables"
    echo "  5. Delete tables"
    echo "  6. Update tables"
    echo "  7. Insert data"
    echo "  8. Delete data"
    echo "  9. Retrieve data"
    echo " 10. Backup Database"
    echo " 11. Restore Database"
    echo " 12. Logs of Databases"
    echo "  0. Exit"
    echo "-----------------------------------"

    read -p "Enter your choice (0-12): " choice

    case "$choice" in
        1)  ./createDB.bash;;
        2) ./deleteDB.bash;;
        3) ./emptyDB.bash ;;
        4) ./createTable.bash ;;
        5) ./deleteTable.bash ;;
        6) ./updateData.bash ;;
        7) ./insertData.bash ;;
        8) ./deleteData.bash ;;
        9) ./retrieveData.bash ;;
        10) ./backUp.bash ;;
        11) ./restore_database.sh ;;
        12) ./showlogs.bash ;;
        0) echo "Exiting..."; exit ;;
        *) echo -e "\033[1;31mInvalid choice. Please enter a number between 0 and 12.\033[0m" ;;
    esac

    # Add a pause after an option is selected
    read -p "Press Enter to continue..."
done
