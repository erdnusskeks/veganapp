source 'https://rubygems.org'

gem 'rails', '3.2.14'

group :development do
  gem 'sqlite3'
end

group :test do
  gem 'rspec-pride', :require => false
  gem "shoulda-matchers"
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'guard-rspec', require: false
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'coveralls', require: false
gem 'psych'