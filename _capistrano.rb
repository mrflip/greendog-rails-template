# Set up capistrano

puts "Setting up Capistrano ... ".magenta

capify!

# Update deploy.rb !!

git :commit => "-am 'Generated Capistrano deployment harness.'"
