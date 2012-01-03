require "colored"
require "rails"
require "haml"
require "bundler"
%w[compass].each do |component|
  raise "Please install #{component}" unless Gem.available?(component)
end

@partials   = File.dirname(__FILE__)
@files_path = File.join(File.dirname(__FILE__),'files')

puts "\n========================================================="
puts " FISCHER'S RAILS 3 TEMPLATE".yellow.bold
puts "=========================================================\n"

def copy_static_file path
  file path, File.read(File.join(@files_path, path))
end

def make_empty_file path
  file path, ""
end

def initializer_from_file filename
  initializer(filename){ File.read(File.join(@files_path, 'config/initializers', filename)) }
end

apply "#{@partials}/_git.rb"           # commit initial repo


puts "\nRemoving unnecessary files ... ".magenta
remove_file "README.rdoc"
remove_file "public/index.html"
remove_file "app/assets/images/rails.png"
remove_file "app/views/layouts/application.html.erb"
remove_file "public/favicon.ico"
run "rm -rf test"
# git :add => '.'
# git :commit => "-am 'removed training wheels and unnecessary files'"

apply "#{@partials}/_gemfile.rb"
apply "#{@partials}/_rvm.rb"         # Must be after gemfile since it runs bundler

apply "#{@partials}/_boilerplate.rb"

# # Stylesheet code must be after boilerplate since it modifies SASS files
# # apply "#{@partials}/_grid1kb.rb"
# apply "#{@partials}/_grid960.rb"
# apply "#{@partials}/_stylesheets.rb"
# apply "#{@partials}/_layouts.rb"
# apply "#{@partials}/_javascripts.rb"
# git :add => '.'
# git :commit => "-am 'Generated grid, stylesheets and layouts.'"

apply "#{@partials}/_helpers.rb"
apply "#{@partials}/_appconfig.rb"
apply "#{@partials}/_application.rb"

# # Following generators must be after application.rb since they run migrations
apply "#{@partials}/_special_pages.rb"
apply "#{@partials}/_rspec.rb"

# apply "#{@partials}/_friendly_id.rb"
# apply "#{@partials}/_forgery.rb"

# apply "#{@partials}/_devise.rb"
#

run "git gc --prune=now"
# puts "\n========================================================="
# puts " INSTALLATION COMPLETE!".yellow.bold
# puts "=========================================================\n\n\n"
