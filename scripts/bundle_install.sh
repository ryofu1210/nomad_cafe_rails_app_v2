#!/bin/bash
su -l rfujii -c 'cd /var/www/projects/nomad_cafe_rails_app_v2 && bundle install --path vendor/bundle'
su -l rfujii -c 'cd /var/www/projects/nomad_cafe_rails_app_v2 && bundle exec rake assets:precompile RAILS_ENV=production'
su -l rfujii -c 'cd /var/www/projects/nomad_cafe_rails_app_v2 && bin/webpack'
