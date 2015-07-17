source 'https://rubygems.org'

ruby '2.2.2'

gem 'bundler'
gem 'rake'

# lotus
gem 'lotusrb',       '0.4.0'  # TODO: Wait for fix in this issue: https://github.com/lotus/lotus/issues/304
gem 'lotus-model',   '~> 0.4'

# auth
gem 'bcrypt'
gem 'omniauth-facebook'

# database
gem 'pg'

# webserver
gem 'puma'

group :development, :test do
  gem 'byebug'
end

group :test do
  gem 'shoulda-lotus'
  gem 'rspec'
  gem 'capybara'
  gem 'codeclimate-test-reporter', group: :test, require: nil
end
