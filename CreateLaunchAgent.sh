#!/bin/bash

############################################################################################################################
## This Script will write a plist and the required script to update inventory and move it to launch daemons.             ##  
## Intended use is with Jamf pro but can be altered to fit any MDM by changing the location of the .sh script.            ##  
##                                                                                                                        ##  
##  By: Matt Durante                                                                                                      ##      
############################################################################################################################


#Create a new plist
sudo defaults write /Library/LaunchDaemons/UpdateInventory.plist Label -string "UpdateInventory"

#Add your arguments to have it run the update script
sudo defaults write /Library/LaunchDaemons/UpdateInventory.plist ProgramArguments -array -string /bin/sh -string "/Library/Application Support/UpdateInventory.sh"

#Set the run inverval to run daily
sudo defaults write /Library/LaunchDaemons/UpdateInventory.plist StartInterval -integer 120

#Set run at load
sudo defaults write /Library/LaunchDaemons/UpdateInventory.plist RunAtLoad -boolean yes

#Change ownership to root (required)
sudo chown root:wheel /Library/LaunchDaemons/UpdateInventory.plist
sudo chmod 644 /Library/LaunchDaemons/UpdateInventory.plist

#Load the daemon 
launchctl load /Library/LaunchDaemons/UpdateInventory.plist
sleep 5


##Create the script to update iventory

cat << 'EOF' > /Library/Application\ Support/UpdateInventory.sh

open -a "Google Chrome" 'https://www.worldwidecyclery.com'

EOF


