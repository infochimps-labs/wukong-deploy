require 'rake'

require 'yard'
YARD::Rake::YardocTask.new(:doc)

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

