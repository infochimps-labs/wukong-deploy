# Require Wukong so we can write processors & dataflows and use
# build-in widgets.
require 'wukong'

# Require just enough of wukong-hadoop to give us changes at the
# processor level.  The rest is only required when running the
# 'wu-hadoop' program.  Also grab configuration since we'll need it.
require 'wukong-hadoop/extensions'
require 'wukong-hadoop/configuration'

# Grab configuration from Wonderdog.
require 'wonderdog/configuration'

module Wukong
  # Provides some helper methods for loading the assets within a
  # deploy pack at runtime and for Wukong plugins to ask questions
  # about the deploy pack they're running in.
  module Deploy
  end
end


# Now load the rest of the deploy pack.
require 'wukong-deploy/deploy_pack'
require 'wukong-deploy/configuration'
