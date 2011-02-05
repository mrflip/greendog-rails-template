# Update things in config/application.rb

puts "Adding password_confirmation to filter_parameters ... ".magenta
gsub_file 'config/application.rb', /:password/, ':password, :password_confirmation'

puts "Turning off timestamped_migrations ...".magenta
inject_into_file 'config/application.rb', :before => "  end\nend" do
  <<-RUBY

    # Turn off timestamped migrations
    config.active_record.timestamped_migrations = false
  RUBY
end

puts "Setting up log file rotation ...".magenta
inject_into_file 'config/application.rb', :before => "  end\nend" do
  <<-RUBY

    # Rotate log files (50 files max at 1MB each)
    config.logger = Logger.new(config.paths.log.first, 50, 1048576)
  RUBY
end

git :commit => "-am 'Configured Application: no timestamped migrations, log rotation, exclude password_confirmation in filter.'"
