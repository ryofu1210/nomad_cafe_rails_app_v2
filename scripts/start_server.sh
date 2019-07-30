#!/bin/bash
su -l rfujii -c 'cd /var/www/projects/nomad_cafe_rails_app_v2 && bundle exec unicorn -D -E production -c config/unicorn.rb'
su -l rfujii -c 'cd /var/www/projects/nomad_cafe_rails_app_v2 && sudo service nginx restart'