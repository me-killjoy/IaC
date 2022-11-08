#!/bin/bash

# Creates random passwords.

# A random number as a password.
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# Three random numbers together.
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# Use the current date/time as the basis for the password.
# $ variable will take whatever in () output  and use it.
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# Use nanoseconds to act as randomization.
# Nano and epoch time since 1970 in sec/nano secs. Why is that still a thing.
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

# A better password.
# Command to check the hash of a file woudl be sha256sum <filename>
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# Even better password.
# man head to see the man page. First 10 lines of each file.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "${PASSWORD}"

# Append a special character to the password.
# | to string together mutiple commands to have it do what you need.
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"