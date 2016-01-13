source 'https://rubygems.org'

ruby '2.3.0'

gem 'bundler'
gem 'rake'

# lotus
gem 'lotusrb',       '0.4.0' # TODO: Wait for fix in this issue: https://github.com/lotus/lotus/issues/30
gem 'lotus-model',   '~> 0.5'

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
  gem 'byebug'
end

group :test do
  gem 'shoulda-lotus'
  gem 'rspec'
  gem 'capybara'
  gem 'codeclimate-test-reporter', group: :test, require: nil
end
