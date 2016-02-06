source 'https://rubygems.org'

ruby '2.3.0'

gem 'bundler'
gem 'rake'

# hanami
gem 'hanami', '~> 0.7.1'
gem 'hanami-model'

# auth
gem 'bcrypt'
gem 'omniauth-facebook'

# database
gem 'pg'

# webserver
gem 'puma'

# aws
gem 'aws-sdk', '~> 2'

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'shoulda-hanami'
  gem 'rspec'
  gem 'capybara'
  gem 'codeclimate-test-reporter', group: :test, require: nil
end
