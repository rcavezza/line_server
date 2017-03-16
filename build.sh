#!/bin/bash -e

# Bundle install rails and create environment
bundle install
rake db:migrate

# Run initial rake file 
rake file_data_tasks:create_line_files[file_very_small.txt]
