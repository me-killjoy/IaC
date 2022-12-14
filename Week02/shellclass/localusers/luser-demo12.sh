#!/bin/bash

# This deletes a user.

# remember to run as root/ sudo
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.' >&2
   exit 1
fi

# Assume the first argument is the user to delete.
USER="${1}"

# Delete the user.
userdel ${USER}

# Make sure the user got deleted.
# -ne = not equal
if [[ "${?}" -ne 0 ]]
then
  echo "The account ${USER} was NOT deleted." >&2
  exit 1
fi

# Tell the user the account was deleted.
echo "The account ${USER} was deleted."

exit 0