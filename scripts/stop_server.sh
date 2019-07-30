#!/bin/bash
su -l rfujii -c 'cd /var/www/projects/nomad_cafe_rails_app_v2 && kill -KILL -s QUIT `cat tmp/pids/unicorn.pid`'