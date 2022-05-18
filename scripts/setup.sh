#!/bin/bash
if [ "$(whoami)" != root ]; then
    echo Please run this script as root or using sudo
    exit
fi


su postgres -c "./create_user_and_database.sh"
su postgres -c "psql -f create_schema.txt"
