#!/usr/bin/env bash

echo 'Copying config files...'
cp config/database.yml.template config/database.yml
cp config/secrets.yml.template config/secrets.yml
cp config/application.yml.template config/application.yml

echo 'Downloading images...'
docker-compose pull

echo 'Installing dependencies...'
docker-compose run web bundle install
docker-compose run web yarn install

echo 'Provisioning database...'
docker-compose run web bundle exec rails db:setup

echo 'Starting application...'
docker-compose up
