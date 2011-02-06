# Set up devise

puts "Setting up devise ... ".magenta

generate 'devise:install'

#
# clear out old migrations
#
Dir['db/migrate/*create_users.rb'].each{|old_migration| puts old_migration ; remove_file(old_migration) }



#
# Generate User model
#
generate "nifty:scaffold User name:string username:string is_local:boolean --rspec --haml"
remove_file 'spec/fixtures/users.yml'
remove_file 'spec/models/user_spec.rb'

#
# Generate Devise
#
generate 'devise User'

#
# Copy in all the views
#
generate "devise:views"

#
# Perform post-install chores for devise
#

inject_into_file 'config/environments/development.rb', :after => %Q{config.action_mailer.raise_delivery_errors = false\n} do
  %Q{config.action_mailer.default_url_options = { :host => 'localhost:3000' }}
end
# override user login routes
gsub_file        'config/routes.rb', /devise_for :users$/, %q{devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' }}

gsub_file "config/initializers/devise.rb", /# config.password_length = 6\.\.20/, %Q{config.password_length = 4..255}

copy_static_file "app/models/user.rb"
%w[ confirmations/new passwords/edit passwords/new registrations/edit registrations/new sessions/new unlocks/new ].each do |devise_view_file|
  copy_static_file "app/views/devise/#{devise_view_file}.html.haml"
end

git :add => '.'
git :commit => "-am 'Generated user auth layer with devise.'"
