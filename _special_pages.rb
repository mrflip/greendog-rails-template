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

git :add => '.'
git :commit => "-am 'Generated homepage and sample pages to demonstrate grid.'"
