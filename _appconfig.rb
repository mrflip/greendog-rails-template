# Set up an APP_CONFIG[] hash from app_config.yml to allow easy configuration
# of custom settings for each app.

puts "Creating custom app configuration hash ...".magenta

copy_static_file 'config/initializers/app_config.rb'
copy_static_file 'config/app_config.yml'

git :add => '.'
git :commit => "-am 'Generated configuration.'"
