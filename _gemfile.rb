# Set up Gemfile

puts "Creating Gemfile ...".magenta

remove_file 'Gemfile'
file 'Gemfile', <<-RUBY.gsub(/^ {2}/, '')
  source 'http://rubygems.org'
  gem 'rails', '3.0.3'
  gem 'unicorn'
  # Database
  group :development, :test do
    gem 'sqlite3-ruby', :require => 'sqlite3'
  end

  # HTML and CSS replacement
  gem 'haml', '~> 3.0'
  gem 'haml-rails'
  gem 'compass'
  gem 'html5-boilerplate'

  # Development
  gem 'friendly_id', '~> 3.1'         # Human readable URLs
  gem 'validates_existence', '~> 0.5' # Validation of associations

  gem 'chronic'                       # Time parsing
  gem 'will_paginate', '~> 3.0.pre2'  # Pagination of long lists
  # gem 'devise', '~> 1.1'            # User management
  # gem 'hpricot'                     # For Devise view generation
  # gem 'ruby_parser'                 # For Devise view generation

  # Testing
  group :test do
    gem 'rspec'
    gem 'rspec-rails'
    # gem "mocha"
    gem 'rcov'
    gem 'forgery'
  end

  group :development do
    gem 'nifty-generators'            # Much better scaffolding
    gem 'taps'                        # Teleportation of databases
    # platforms :ruby_19 do
    #   gem 'ruby-debug19'
    # end
    # platforms :ruby_18 do
    #   gem 'ruby-debug'
    # end
  end

  group :console do
    gem 'wirble'
    gem 'hirb'
    gem 'looksee'
    gem 'awesome_print'
  end
RUBY

git :commit => "-am 'Gemfile.'"
