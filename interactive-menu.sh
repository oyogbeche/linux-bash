#!/bin/bash

#Create a script with a menu that allows the user to:
#View system status.
#Start and stop services.
#Check disk usage.
#Exit the script.

PS3="Select a task: "  
select ITEM in "View System Status" "start and stop services" "check disk usage" "Exit the Script"
do


if [[ $REPLY -eq 1 ]] 
then
    echo "########################"
    echo "VIEWING SYSTEM STATUS..."
    echo "########################"
    sleep 2

    echo "########################"
    echo "Displaying systen and hostname information..."
    echo "########################"
    sleep 2
    hostnamectl

    echo "########################"
    echo "Displaying network information..."
    echo "########################"
    sleep 2
    ip a
    
    echo "########################"
    echo "Listing information about block devices..."
    echo "########################"
    sleep 2
    lsblk
    exit


        elif [[ $REPLY -eq 2 ]]
            then
             echo "Enter the name of the service you want to install (or type 'exit' to return to the main menu):"
                read -r service_name

                # Exit if the user types 'exit'
                if [[ $service_name == "exit" ]]; then
                    break
                fi

                # Check if the service can be installed
                if apt-cache show "$service_name" >/dev/null 2>&1; then
                    echo "############################"
		    echo "Installing $service_name..."
		    echo "############################"
                    sudo apt-get update && sudo apt-get install -y "$service_name"
                    if [[ $? -eq 0 ]]; then
                        echo "$service_name was installed successfully."

			echo "#########################"
			echo "Stopping $service_name"
			echo "#########################"
			sudo systemctl stop $service_name
			echo "$service_name was stopped successfully"
                        break
                    else
                        echo "Failed to install $service_name. Please try again."
                    fi
                else
                    echo "'$service_name' is not a valid service. Please enter a valid service name."
                fi
           


elif [[ $REPLY -eq 3 ]] 
then
    echo "####################"
    echo "Checking disk usage"
    echo "###################"
    sleep 2
    df -h
    exit


elif [[ $REPLY -eq 4 ]]
then
    echo "Exiting..."
    sleep 2
    exit

else
    echo "Invalid menu selection" 
fi

done
