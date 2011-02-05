# Add some demo html pages. These can be deleted at any time.

puts "Creating demo pages ...".magenta

inject_into_file 'config/routes.rb', :after => ".routes.draw do\n" do
  <<-RUBY.gsub(/^ {2}/, '')
    root :to => "special_pages#homepage"

    match 'admin/grid' => 'special_pages#grid'
    match 'admin/text' => 'special_pages#text'

  RUBY
end

copy_static_file 'app/controllers/special_pages_controller.rb'
copy_static_file 'app/views/special_pages/homepage.html.haml'
copy_static_file 'app/views/special_pages/text.html.haml'
copy_static_file 'app/views/special_pages/grid.html.haml'

git :commit => "-am 'Generated homepage and sample pages to demonstrate grid.'"
