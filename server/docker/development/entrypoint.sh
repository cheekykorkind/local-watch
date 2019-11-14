#!/bin/bash
set -e

# set permission for web container work on db container
sudo chmod 777 -R /home/${UNAME}/myapp/tmp/

# Handle updated Gemfile 
bundle install

# For 'Your Yarn packages are out of date! Please run "yarn install --check-files" to update'
yarn install --check-files

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"