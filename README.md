# The Madeline System

## Requirements
* ruby 2.x
* postgresql
* mysql (for migrating legacy data)

## Getting Started
    git clone git@github.com:elliottjf/madeline.git
    cd madeline
    bundle install
    cp config/database.yml.example config/database.yml
    emacs config/database.yml
    cp config/secrets.yml.example config/secrets.yml
    emacs config/secrets.yml
    rake db:drop db:create db:migrate
    rake tww:migrate_legacy
    rails s
