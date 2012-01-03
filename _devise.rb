# Set up devise

puts "Setting up devise ... ".magenta

skip_migration = false

generate 'devise:install'

#
# clear out old migrations
#
Dir['db/migrate/*create_users.rb'].each{|old_migration| puts old_migration ; remove_file(old_migration) } unless skip_migration

#
# Generate User model
#
generate "nifty:scaffold User name:string username:string index --rspec --haml #{skip_migration ? '--skip-migration' : '' }"
remove_file 'spec/fixtures/users.yml'
remove_file 'spec/models/user_spec.rb'

# Rails::Generators.invoke "migration", %w(add_fields_to_users name:string username:string is_local:boolean --orm=active_record)

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
  %Q{config.action_mailer.default_url_options = { :host => 'localhost:3000' }\n}
end

# override user login routes
gsub_file        'config/routes.rb', /devise_for :users$/, %q{devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' }}

gsub_file "config/initializers/devise.rb", /# config.password_length = 6\.\.20/, %Q{config.password_length = 4..255}
gsub_file "config/routes.rb",              /resources :users\n/, %Q{
  resources :users, :only => [:index]
  as :user do
    get "users/:id" => "devise/registrations#edit", :as => :user
  end
}

%w[
 app/models/user.rb
 app/views/users/show.html.haml
 app/views/users/index.html.haml
].each do |file|
  remove_file      file
  copy_static_file file
end

%w[ confirmations/new passwords/edit passwords/new registrations/edit registrations/new sessions/new unlocks/new ].each do |devise_view_file|
  copy_static_file "app/views/devise/#{devise_view_file}.html.haml"
end

git :add => '.'
git :commit => "-am 'Generated user auth layer with devise.'"

#
# post-install
#

inject_into_file 'config/application.rb', :after => "config.assets.enabled = true\n" do
<<-RUBY

    # don't hit the DB when compiling assets
    config.assets.initialize_on_precompile = false
RUBY
end

git :add => '.'
git :commit => "-am 'devise post-install maintenance.'"

#
# run migration
#

rake      'db:migrate'
git       :add => '.'
git       :commit => "-am 'Ran devise migration.'"
