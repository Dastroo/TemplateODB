#!/bin/bash

user="templateodb"
database="templateodb_db"

echo "enter new password for ${user}:"
createuser "$user" -P

createdb "$database"

