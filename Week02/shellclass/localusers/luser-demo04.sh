#!/bin/bash

# This script creates an account on the local system.
# You will be prompted for the account name and password.

# Ask for the user name. read -p will set variable when the user answers prompts.
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name.
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user. What the user filled out will create the usr/pw. the -m creates home dir.
# comment is in quotes becase it may contain spaces. 
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for the user.
# NOTE: You can also use the following command:
#    echo "${USER_NAME}:${PASSWORD}" | chpasswd
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login. 
# -e expires the password and prompts the user on next logon.
passwd -e ${USER_NAME}

# Once done writign the script, chmod +x luser-demo04.sh as it's the first time. 
#   running the script.
# sudo ./luser-demo04.sh to run the script.
# create the user, choose password. SU - <name> and log on. Then choose a new password. 
# 