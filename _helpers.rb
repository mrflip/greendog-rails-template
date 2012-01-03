# Set up some view helpers and partials

puts "Creating useful application_helper.rb ...".magenta

remove_file      'app/helpers/application_helper.rb'
copy_static_file 'app/helpers/application_helper.rb'
copy_static_file 'app/helpers/error_messages_helper.rb'
copy_static_file 'app/views/misc/_error_messages.html.haml'

git :add => '.'
git :commit => "-am 'Generated Helpers.'"
