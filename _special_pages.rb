# Add some demo html pages. These can be deleted at any time.

puts "Creating demo pages ...".magenta

inject_into_file 'config/routes.rb', :after => ".routes.draw do\n" do
  <<-RUBY.gsub(/^ {2}/, '')
    root :to => "misc#homepage"

    match 'admin/demo'           => 'misc#demo'
    match 'admin/bootstrap_demo' => 'misc#bootstrap_demo'
  RUBY
end

copy_static_file 'app/controllers/misc_controller.rb'
copy_static_file 'app/views/misc/homepage.html.haml'
copy_static_file 'app/views/misc/demo.html.haml'
copy_static_file 'app/views/misc/bootstrap_demo.html.erb'

%w[
  bootstrap-dropdown.js
  bootstrap-scrollspy.js
  bootstrap-twipsy.js
  bootstrap.css
  bootstrap_demo/bootstrap_demo.css
  bootstrap_demo/bootstrap_demo.js
  bootstrap_demo/ico/bootstrap-apple-114x114.png
  bootstrap_demo/ico/bootstrap-apple-57x57.png
  bootstrap_demo/ico/bootstrap-apple-72x72.png
  bootstrap_demo/images/bird.png
  bootstrap_demo/images/browsers.png
  bootstrap_demo/images/example-diagram-01.png
  bootstrap_demo/images/example-diagram-02.png
  bootstrap_demo/images/example-diagram-03.png
  bootstrap_demo/images/grid-18px.png
  google-code-prettify/prettify.css
  google-code-prettify/prettify.js
  jquery.tablesorter.min.js
].each{|asset| copy_static_file("public/assets/#{asset}")}

git :add => '.'
git :commit => "-am 'Generated homepage and sample pages to demonstrate grid.'"
