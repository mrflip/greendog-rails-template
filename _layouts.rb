# Set up default haml layout

puts "Creating default layout ...".magenta

remove_file 'app/views/layouts/_footer.html.haml'
copy_static_file 'app/views/layouts/_footer.html.haml'

remove_file 'app/views/layouts/_header.html.haml'
copy_static_file 'app/views/layouts/_header.html.haml'

copy_static_file 'app/views/layouts/_nav.html.haml'

# This needs to be kept up to date as the boilerplate and sporkd gem get updated
remove_file 'app/views/layouts/application.html.haml'
copy_static_file 'app/views/layouts/application.html.haml'

git :add => '.'
git :commit => "-am 'Generated layouts.'"
