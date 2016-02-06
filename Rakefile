require 'rake'
require 'hanami/rake_tasks'

if ENV['HANAMI_ENV'] != 'production'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
end

