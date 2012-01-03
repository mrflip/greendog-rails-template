# Set up rvm private gemset

puts "Setting up RVM gemset and installing bundled gems (may take a while) ... ".magenta

current_ruby = `rvm list`.match(/=> ([^ ]+)/)[1]
# desired_ruby = ask("Which RVM Ruby would you like to use? [#{current_ruby}]".red)
desired_ruby = current_ruby if desired_ruby.blank?

# gemset_name = ask("What name should the custom gemset have? [#{@app_name}]".red)
gemset_name = @app_name if gemset_name.blank?

puts "  using #{current_ruby}@#{gemset_name} ... ".blue

# Let us run shell commands inside our new gemset. Use this in other template partials.
@rvm = "rvm #{desired_ruby}@#{gemset_name}"

# Create .rvmrc
file '.rvmrc', @rvm
puts "                  #{@rvm}".yellow

# # Make the .rvmrc trusted
# puts "  rvm trust  ... ".blue
# run "rvm rvmrc trust #{@app_path}"
#
# # Since the gemset is likely empty, manually install bundler so it can install the rest
# puts "  gem install bundle ... ".blue
# run "#{@rvm} gem install bundler"

# Install all other gems needed from Gemfile
puts "  bundle update, may take a while ... ".blue
run "#{@rvm} exec bundle update --local"

git :add => '.'
git :commit => "-am 'Generated rvm.'"
