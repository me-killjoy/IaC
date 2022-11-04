#!/bin/bash

# CThis is to create a local user.
# this will need to be ran as SU.
if [[ "${UID}" -ne 0 ]]
Then
    echo 'Please run with sudo or as root.'
    exit 1
fi


# Prompt user to create a username.
read -p 'Enter the username to create: ' USER_NAME

# Ask for full name.
read -p 'Enter First and Last Name of the person who this account is for: ' COMMENT

# Create a password prompt
read -p 'Enter the password to use for the account: ' PASSWORD

# Account creation. 
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd succedded.
if [[ "${?}" -ne 0 ]]
then 
    echo "The account could not be created."
    exit 1
fi 

# Set user password.
echo "${USER_NAME}:${PASSWORD}" | chpasswd

if [[ "${?}" -ne 0 ]]
then 
    echo "The password could not be created."
    exit 1
fi 

# Prompt use for new password after first log on
passwd -e ${USER_NAME}

# show username, password, and the host where the user was created. 
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${COMMENT}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0