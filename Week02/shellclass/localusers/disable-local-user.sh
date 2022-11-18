#!/bin/bash

# This sript disabled, deleted, and/or archives users on the local system.

ARCHIVE_DIR='/archive'

usage() { 
    #Display the usage and exit
    echo "usage: ${0} [-dra] USER [USERN]..." >&2
    echo 'Disable a local Linux account.' >&2
    echo '  -d Deletes accounts instead of disabling them.' >&2
    echo '  -r  Removes the home directory associated with the account(s).' >&2
    echo '  -a  Creates an archive of the home directory asssociated with the account(s).' >&2
    exit 1
}


# Make sure the script is being executred with the useruser privileges
if [[ "${UID}" -ne 0 ]]
then 
    echo 'Please run with sudo or as root.' >&2
    exit 1
fi
# Parse the options 
while getopts dra OPTION
do
    case ${OPTION} in
    d) DELETE_USER='true' ;;
    r) REMOVE_OPTION='-r' ;;
    a) ARCHIVE='true' ;;
    esac
done

# Remove the options while leaing the remaining arguments. 
shift "$(( OPTIND - 1 ))"

# if the user does not supply at least one argument, give them help.
# -lt = less than
if [[ "${#}" -lt 1 ]]
then 
    usage
fi

# Loop therough all the usernames supplied as arguments.
for USERNAME in "${@}"
do 
    echo "processing user: ${USERNAME}"

    # Make sure the UID of the acocunt is at least 1000.
    USERID=$(id -u ${USERNAME})
    if [[ "${USERID}" -lt 1000 ]]
    then   
    echo "Refusing to remove the ${USERNAME} account with UID ${USERID}." >&2
    exit 1
fi
# Create an archive if requested to do so.

if [[ "{ARCHIVE}" = 'true' ]]
then 
    # Make sure the ARCHIVE_DIR directory exists.
    # ! test.
    #mkdir -p makes parent directories
    if [[ ! -d "${ARCHIVE_DIR}" ]]
    then 
        echo "Creating ${ARCHIE_DIR} directory."
        mkdir -p ${ARCHIVE_DIR}
        if [[ "${?}" -ne 0 ]]
        then 
        echo "The archive directory ${ARCHIVE_DIR} could not be created." >&2
        exit 1
    fi
fi
# Arvhive the user's home directory and move it into the ARCHIVE_DIR
HOME_DIR="/home/${USERNAME}"
ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
if [[ -d "${HOME_DIR}" ]]
then 
    echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
    tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
    if [[ "${?}" -ne 0 ]]
    then 
        echo "Could not create ${ARCHIVE_FILE}." > &2
        exit 1
    fi
else
    echo "${HOME_DIR} does not exit or is not a directory." >&2
    exit 1
fi
fi

#near the ending received Video error. 
