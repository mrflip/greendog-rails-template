# Install twitter-bootstrap css defaultness

puts "Setting up HTML5 Boilerplate with HAML, SASS, and Compass ...".magenta

remove_file      'app/assets/stylesheets/application.css'
copy_static_file 'app/assets/stylesheets/application.sass'
copy_static_file 'app/assets/stylesheets/bootstrap.sass'

copy_static_file 'config/compass.rb'
copy_static_file 'app/views/misc/bootstrap_demo.html.erb'

gsub_file( 'app/assets/javascripts/application.js', /.*require jquery\s+\n?/, '')

inject_into_file 'config/application.rb', :after => "config.assets.enabled = true\n" do
<<-RUBY

    # Compass integration
    config.sass.load_paths << Compass::Frameworks['compass'].stylesheets_directory
    config.sass.load_paths << Compass::Frameworks['twitter_bootstrap'].stylesheets_directory
RUBY
end


%w[
  bootstrap/bootstrap-dropdown.js
  bootstrap/bootstrap-scrollspy.js
  bootstrap/bootstrap-twipsy.js
  bootstrap/demo/bootstrap_demo.css
  bootstrap/demo/bootstrap_demo.js
  bootstrap/demo/grid-18px.png
  google-code-prettify/prettify.css
  google-code-prettify/prettify.js
  jquery.tablesorter.js
].each{|asset| copy_static_file("public/assets/#{asset}")}
git :add => '.'
git :commit => "-am 'Twitter Bootstrap Helpers.'"

%w[
  hashgrid.js
].each{|asset| copy_static_file("public/assets/#{asset}")}
git :add => '.'
git :commit => "-am 'Hashgrid grid visualizer.'"

%w[
  jquery.bbq.js
  jquery.touch_events.js
  sprintf.js
].each{|asset| copy_static_file("public/assets/#{asset}")}
git :add => '.'
git :commit => "-am 'jQuery helpers.'"

%w[
  coffee-script.js
  underscore.coffee
].each{|asset| copy_static_file("public/assets/#{asset}")}
git :add => '.'
git :commit => "-am 'javascript utils.'"

%w[
  app/views/layouts/application.html.haml
  app/views/layouts/_flashes.html.haml
  app/views/layouts/_footer.html.haml
  app/views/layouts/_htmlhead.html.haml
  app/views/layouts/_javascripts.html.haml
  app/views/layouts/_sidebar.html.haml
  app/views/layouts/_topbar.html.haml
  app/assets/stylesheets/page.sass
].each{|asset| copy_static_file(asset)}
git :add => '.'
git :commit => "-am 'javascript utils.'"
