# Install Paul Irish's HTML5 Boilerplate HTML/CSS via the sporkd gem

puts "Setting up HTML5 Boilerplate with HAML, SASS, and Compass ...".magenta

# # unnecessary now
# initializer_from_file('sass_config.rb')

file 'config/compass.rb', <<-RUBY.gsub(/^ {2}/, '')
  require 'html5-boilerplate'
  require 'ninesixty'

  project_type     = :rails
  project_path     = Compass::AppIntegration::Rails.root
  http_path        = "/"
  css_dir          = "public/stylesheets"
  sass_dir         = "app/stylesheets"
  javascripts_dir  = "public/javascripts"
  images_dir       = "public/images"
  environment      = Compass::AppIntegration::Rails.env
  preferred_syntax = :sass

  if Compass::AppIntegration::Rails.env == :development
    output_style = :nested
  else
    output_style = :compressed
  end
RUBY

run "compass init rails --require html5-boilerplate -u html5-boilerplate --syntax sass -c config/compass.rb --force"
