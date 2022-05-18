#!/bin/bash
if [ "$(whoami)" != root ]; then
    echo Please run this script as root or using sudo
    exit
fi

if [ -f "/etc/redhat-release" ]; then
    dnf install postgresql-server postgresql-contrib
    systemctl enable postgresql
    postgresql-setup --initdb --unit postgresql
    systemctl start postgresql
fi
