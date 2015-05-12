#!/usr/bin/env bash

echo "Provisioning virtual machine..."

# PPA
if [ ! -f "/etc/apt/sources.list.d/pgdg.list" ]; then
    echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
fi

# Packages
apt-get update

apt-get install -y htop vim git curl build-essential libssl-dev libmagick++-dev postgresql-9.3

locale-gen ru_RU.UTF-8

# Install RVM & Ruby

su - vagrant -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
su - vagrant -c "\curl -sSL https://get.rvm.io | bash --ruby=2.2.1"
