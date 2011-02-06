require "colored"
require "rails"
require "haml"
require "bundler"
%w[html5-boilerplate compass].each do |component|
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

def initializer_from_file filename
  initializer(filename){ File.read(File.join(@files_path, 'config/initializers', filename)) }
end


puts "\nRemoving unnecessary files ... ".magenta
remove_file "README"
remove_file "public/index.html"
remove_file "public/index.html"
remove_file "public/images/rails.png"
remove_file "app/views/layouts/application.html.erb"
# remove prototype files
remove_file "public/javascripts/controls.js"
remove_file "public/javascripts/dragdrop.js"
remove_file "public/javascripts/effects.js"
remove_file "public/javascripts/prototype.js"
remove_file "public/javascripts/jrails.js"
remove_file "test/performance/browsing_test.rb"
remove_file "test/test_helper.rb"

apply "#{@partials}/_git.rb"           # commit initial repo
apply "#{@partials}/_gemfile.rb"
# apply "#{@partials}/_rvm.rb"         # Must be after gemfile since it runs bundler
apply "#{@partials}/_boilerplate.rb"
apply "#{@partials}/_grid.rb"          # Must be after boilerplate since it modifies SASS files
apply "#{@partials}/_stylesheets.rb"   # Must be after boilerplate since it modifies SASS files
apply "#{@partials}/_layouts.rb"       # Must be after boilerplate since it modifies HAML files
git :add => '.'
git :commit => "-am 'Generated boilerplate, grid, stylesheets and layouts.'"
apply "#{@partials}/_helpers.rb"
apply "#{@partials}/_appconfig.rb"
apply "#{@partials}/_rspec.rb"
# apply "#{@partials}/_capistrano.rb"
apply "#{@partials}/_application.rb"
# Following generators must be after application.rb since they run migrations
apply "#{@partials}/_friendly_id.rb"
apply "#{@partials}/_forgery.rb"
apply "#{@partials}/_special_pages.rb"
apply "#{@partials}/_devise.rb"

puts "\n========================================================="
puts " INSTALLATION COMPLETE!".yellow.bold
puts "=========================================================\n\n\n"
