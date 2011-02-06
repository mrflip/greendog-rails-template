# Set up devise

puts "Setting up devise ... ".magenta

generate 'devise:install'

Dir['db/migrate/*_devise_create_users.rb'].each{|old_migration| puts old_migration ; remove_file(old_migration) }

generate 'devise User'
remove_file 'spec/fixtures/users.yml'
remove_file 'spec/models/user_spec.rb'

# # Run this to also copy in all the views
generate "devise:views"

# Perform post-install chores for devise
inject_into_file 'config/environments/development.rb', :after => %Q{config.action_mailer.raise_delivery_errors = false\n} do
  %Q{config.action_mailer.default_url_options = { :host => 'localhost:3000' }}
end
# override user login routes
gsub_file        'config/routes.rb', /devise_for :users$/, %q{devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' }}
inject_into_file 'config/routes.rb', :before => /\n\s+devise_for :users/ do
  %Q{
  get 'users/login'  => 'devise/sessions#new',      :as => :login
  get 'users/logout' => 'devise/sessions#destroy',  :as => :logout
  get 'users/signup' => 'devise/registrations#new', :as => :signup
}
end

git :add => '.'
git :commit => "-am 'Generated user auth layer with devise.'"
