# = config/boot.rb
#
# Loads the Ruby language framework and activates Bundler.
#
# We can use a system-wide bundle installation _or_ a standalone
# bundle installation.  If a standalone installation exists (at
# /bundle/bundler/setup.rb), we will detect and use it.  Otherwise, we
# fall back on the system-wide bundle installation.
#
# Make sure you install the bundle locally with the following command:
#
# @example Install a standalone bundle of gems
#
#   $ bundle install --standalone

local_setup_path = File.expand_path("../../bundle/bundler/setup.rb", __FILE__)
if File.exist?(local_setup_path)
  begin
    require local_setup_path
  rescue LoadError => e
    $stderr.puts("Local Bundle installation at #{local_setup_path} is corrupted.  Try running\n\n  rm -rf bundle .bundle\n  bundle install --standalone\n\n")
    exit(1)
  end
else
  require 'bundler/setup'
end
