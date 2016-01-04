# The Madeline System

## Requirements
* ruby 2.x
* postgresql
* mysql (for migrating legacy data)

## Getting Started
    git clone git@github.com:elliottjf/madeline.git
    cd madeline
    bundle install
    cp config/local_configs/_reference.yml config/local_configs/`hostname`.yml
    emacs config/local_configs/`hostname`.yml
    # (for more information, you can read config/local_configs/_readme.txt)
    rake db:drop db:create db:migrate
    rake tww:migrate_legacy
    rails s
