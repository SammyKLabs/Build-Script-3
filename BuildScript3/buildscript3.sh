#!/bin/bash

# My name is Sammy Cespedes and in this script I am creating a user's account by prompting them for a username and password then placing their credentials within a GitAcc group
#Once the user is read to Add and Commit, my script will guide them through the process

# the groupadd -f forces the command to abort if the group given already exists, this will force the group to be added
# the useradd -m option will create the user's home directory
# the useradd -g option signifies the login group

# after successfully adding the user to the GitAcc group, I prompt the user to make their first commit: the git options specified will ask the user for the description of their first commit and then i>

#Trouble Shooting
#the groupadd -g option did not initially work for me as it would output that the group does not exist and would not add the GitAcc as a group id
#Unexpected end of file, properly placing fi and ending my if/then statements so the script does not break
#After the user makes their first commit, my script does not account for the specific master branch they are committing to, thus it will prompt the user to specify the location of the remote repo

echo "Welcome user, we will be creating a Git Account?"
echo "First, you must be a superuser to proceed"

if [[ $UID != 0 ]];
then
echo "superuser not detected"
exit 1

else
echo "You are a Superuser"
echo "-------------------"
echo "Please enter a username for your account"
read uname

echo "-------------------"
echo "Also enter a password for your account"
read password

echo "creating your account with username:" $uname "and password:" $password
echo "--------------------------------------"
echo "Do you want to proceed with your account creation?"
read response
fi

if [[ $response = yes ]];
then
groupadd -f GitAcc
useradd -m -g GitAcc -s /bin/bash $uname

echo "User:" $uname "has been created in group: Git Acc"
echo "----------------------------------"
echo "Thank you"

fi

echo "-----------------------------"
echo "Are you ready to add and commit to your Git Account"
read response

if [[ $response = yes ]];
then
read -p "Commit description:" desc
git add -A
git commit -m "$desc" && \
git push origin HEAD
exit 0
fi