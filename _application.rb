# Update things in config/application.rb

puts "Adding password_confirmation to filter_parameters ... ".magenta
gsub_file 'config/application.rb', /:password\]/, ':password, :password_confirmation]'

gsub_file('config/application.rb',
  /# config.active_record.whitelist_attributes = true/,
  'config.active_record.whitelist_attributes = true')
gsub_file( 'config/application.rb',
  /^\s*# config.autoload_paths.*/,
  %Q{    # to debug a plugin, add it here eg "#{Rails.root}/vendor/plugins/ajaxful_rating/lib"
    config.autoload_paths += [ "#{Rails.root}/app/sweepers" ]}
  )

puts "Copying in static files"
copy_static_file "LICENSE.textile"
copy_static_file "public/favicon.ico"
copy_static_file "public/humans.txt"
copy_static_file "public/crossdomain.xml"
copy_static_file "public/apple-touch-icon.png"

make_empty_file  'app/sweepers/.gitkeep'

puts "Turning off timestamped_migrations ...".magenta
inject_into_file 'config/application.rb', :before => "  end\nend" do
  <<-RUBY

    # Turn off timestamped migrations
    config.active_record.timestamped_migrations = false

    # Rotate log files (50 files max at 1MB each)
    # might not work anymore on rails 3.2
    # config.logger = Logger.new(config.paths.log.first, 50, 20 * 1048576)

  RUBY
end

inject_into_file 'config/environments/development.rb',
  :after => "config.action_controller.perform_caching = false.*\n" do
<<-RUBY
  # # mimic production caching if env var is set
  # if ENV['MIMIC_PRODUCTION_CACHING']
  #  config.action_controller.perform_caching = true
  #  config.cache_store = :dalli_store
  # end
RUBY
end

inject_into_file 'config/environments/development.rb',
  :before => "  # Print deprecation notices" do
<<-RUBY

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # # For fiddling with a plugin, uncomment this line and the one in
  # # config/application.rb about config.autoload_paths
  # ActiveSupport::Dependencies.explicitly_unloadable_constants = ['MyPlugin']

RUBY
end

gsub_file('config/environments/production.rb',
  /^\s*# config.cache_store = :mem_cache_store/,
%Q{  config.cache_store = :dalli_store, { :expires_in => 1.hours, :namespace => '20110906-0656' }
  # Enable Rails's static asset server for heroku
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=86400"
})

# TODO:
# ActiveRecord::Base.logger = Rails.logger

git :add => '.'
git :commit => "-am 'Configured Application: no timestamped migrations, log rotation, exclude password_confirmation in filter.'"
