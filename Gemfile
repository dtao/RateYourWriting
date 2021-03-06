source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use Postgres as the database for Active Record
gem 'pg'

# Use Foreman for configuration
gem 'foreman'

# Use HAML for markup
gem 'haml-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Markdown for formatting submission content
gem 'redcarpet'

# Use CodeMirror for editing submissions
gem 'codemirror-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Use Cheapskate for handling HTTP/HTTPS switching during registration and login
gem 'cheapskate', :github => 'dtao/cheapskate'

# Use Randy to generate random tokens for e-mail verification
gem 'randy'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'debugger'
  gem 'mustache'
  gem 'query_diet', :github => 'dtao/query_diet'
end

group :test do
  gem 'rspec-rails'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use thin as the app server
gem 'thin'
