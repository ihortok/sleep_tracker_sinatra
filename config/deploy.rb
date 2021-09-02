# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

set :application, 'sleeptracker'
set :repo_url, 'git@github.com:ihortok/sleep_tracker_sinatra.git'

# Deploy to the user's home directory
set :deploy_to, "/home/deploy/#{fetch :application}"

# Only keep the last 5 releases to save disk space
set :keep_releases, 1

# Optionally, you can symlink your database.yml and/or secrets.yml file from the shared directory during deploy
# This is useful if you don't want to use ENV variables
# append :linked_files, 'config/database.yml', 'config/secrets.yml'
set :branch, 'deploy'
set :passenger_restart_with_touch, true
