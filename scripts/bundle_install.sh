#!/bin/bash

cd /var/www/projects/nomad_cafe_rails_app_v2
bundle install --path vendor/bundle
bundle exec rake assets:precompile RAILS_ENV=production
kill -QUIT `cat tmp/pids/unicorn.pid`
