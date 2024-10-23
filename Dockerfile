#!/bin/bash

# Array of user names
declare -a users=("user1" "user2" "user3")

# Create each user and set up their home directory
for user in "${users[@]}"
do
    # Create the user with a home directory
    useradd -m -s /bin/bash $user

    # Create a workspace for the user
    mkdir -p /workspace/$user

    # Set the home directory to their workspace folder
    ln -s /workspace/$user /home/$user/work

    # Change ownership of their workspace
    chown -R $user:$user /workspace/$user

    # Allow the user to run Jupyter
    echo "$user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
done

# Start Jupyter
exec start-notebook.sh
