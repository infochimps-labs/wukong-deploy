require 'rake'

require 'wukong/rake_helper'

require 'yard'
YARD::Rake::YardocTask.new(:doc) do |t|
  t.files   = %w[app/**/*.rb Rakefile Gemfile]
  t.options = ['--load', Wukong.doc_helpers_path]
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

