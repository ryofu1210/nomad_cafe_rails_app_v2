#!/bin/bash
cd /var/www/projects/nomad_cafe_rails_app_v2
su -l rfujii -c 'bundle install --path vendor/bundle'
su -l rfujii -c 'bundle exec rake assets:precompile RAILS_ENV=production'
su -l rfujii -c 'kill -QUIT `cat tmp/pids/unicorn.pid`'
