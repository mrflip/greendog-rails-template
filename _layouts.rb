# Set up default haml layout

puts "Creating default layout ...".magenta

# we do the jquery including
gsub_file( 'app/assets/javascripts/application.js', /.*require jquery\s+\n?/, '')

remove_file      'app/assets/stylesheets/application.css'

%w[
  app/views/layouts/application.html.haml
  app/views/layouts/_flashes.html.haml
  app/views/layouts/_footer.html.haml
  app/views/layouts/_htmlhead.html.haml
  app/views/layouts/_javascripts.html.haml
  app/views/layouts/_sidebar.html.haml
  app/views/layouts/_topbar.html.haml
  app/assets/stylesheets/application.sass
  app/assets/stylesheets/page.sass
].each do |asset|
  remove_file      asset
  copy_static_file asset
end

git :add => '.'
git :commit => "-am 'layout files.'"
