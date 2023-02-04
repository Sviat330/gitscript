#!/bin/bash
#check if user with root priviliges
if [[ $(/usr/bin/id -u) -ne 0 ]]
then
        echo "Not running as root"
        exit
fi
username=$1
#check the count of user input if not equal 1 echo msg and exit
echo $#
if [ ! $# -eq 1 ]
then
	echo "Usage script is: script name_of_user"
	exit 1
fi
#last uid of user in linux
LASTUID=$(cat /etc/passwd | cut -d : -f 3 | sort -h | tail -n -2 | head -1)

#First free user id
let USERUID=$LASTUID+1
echo $USERUID is uid of $username
#addgrp --gid $USERID
echo "Write a comment that describe you"
read comment
echo "Choose shell from list for your user "
cat /etc/shells | tail -n +2
read usersh
cat /etc/shells | grep -l "$usersh"
if [ $? -eq 0 ]
then
	echo Good
else
	echo "You choose incorrect shell"
	exit 2
fi
echo "Enter max num of days the password is valid"
read expdate
echo "Enter extra groups in which your user must be"
read usergroups
mkdir /home/$username
#mkdir /home/$username
echo "$username:x:$USERUID:$USERUID:$comment:/home/$username:$usersh" >> /etc/passwd
echo "$username::0:0:$expdate:7:::" >> /etc/shadow

echo "$username:x:$USERUID:" >> /etc/group
#add sec groups to user 
for group in $usergroups
do
	echo $group
	sed -i "/^$group/ s/$/,lol/" /etc/group
done
chown -R $username:$username /home/$username

