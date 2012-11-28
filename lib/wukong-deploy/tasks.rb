require 'rake'

namespace 'bundler' do
  desc "Update local bundle repository"
  task :update do
    
  end

  desc "Install gems locally"
  task :install do
    sh "bundle install --standalone"
  end
end

  
