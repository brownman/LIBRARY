#!/bin/bash
# secret-pw.sh: secret password

echo
echo -n "Enter password "
read passwd
echo "password is $passwd"
echo -n "If someone had been looking over your shoulder, "
echo "your password would have been compromised."

echo && echo  # Two line-feeds in an "and list."


stty -echo    # Turns off screen echo.

echo -n "Enter password again "
read passwd
echo
echo "password is $passwd"
echo

stty echo     # Restores screen echo.

exit 0

# Do an 'info stty' for more on this useful-but-tricky command.
