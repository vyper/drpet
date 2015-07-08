require 'rubygems'
require 'bundler/setup'
require 'lotus/setup'
require_relative '../lib/drpet'
require_relative '../apps/api/application'
require_relative '../apps/web/application'

Lotus::Container.configure do
  mount Api::Application, at: '/api/v1'
  mount Web::Application, at: '/'
end
