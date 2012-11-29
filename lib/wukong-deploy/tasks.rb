require 'rake'

namespace 'bundler' do
  desc "Remove local bundle repository"
  task :clean do
    Wukong::Deploy.logger.info "Removing local bundle at /.bundle and /bundle"
    sh "rm -rf .bundle bundle"
    Wukong::Deploy.logger.info "Make sure to run 'bundle install --standalone' to re-create the bundle"
  end
  
end

  
