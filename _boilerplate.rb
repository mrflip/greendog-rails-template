# Install twitter-bootstrap css defaultness

puts "Setting up HTML5 Boilerplate with HAML, SASS, and Compass ...".magenta

remove_file      'app/assets/stylesheets/application.css'
copy_static_file 'app/assets/stylesheets/application.sass'
copy_static_file 'app/assets/stylesheets/bootstrap.sass'

copy_static_file 'config/compass.rb'
copy_static_file 'app/views/misc/bootstrap_demo.html.erb'

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
  bootstrap/demo/ico/bootstrap-apple-114x114.png
  bootstrap/demo/ico/bootstrap-apple-57x57.png
  bootstrap/demo/ico/bootstrap-apple-72x72.png
  bootstrap/demo/images/bird.png
  bootstrap/demo/images/browsers.png
  bootstrap/demo/images/example-diagram-01.png
  bootstrap/demo/images/example-diagram-02.png
  bootstrap/demo/images/example-diagram-03.png
  bootstrap/demo/images/grid-18px.png
  google-code-prettify/prettify.css
  google-code-prettify/prettify.js
  jquery.touch_events.js
  jquery.tablesorter.js
  jquery.bbq.js
  hashgrid.js
  sprintf.js
  coffee-script.js
  underscore.coffee
].each{|asset| copy_static_file("public/assets/#{asset}")}

git :add => '.'
git :commit => "-am 'Generated boilerplate.'"
