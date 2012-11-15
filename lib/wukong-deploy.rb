# Require Wukong so we can write processors & dataflows and use
# build-in widgets.
require 'wukong'

# Require just enough of wukong-hadoop to give us changes at the
# processor level.  The rest is only required when running the
# 'wu-hadoop' program.
require 'wukong-hadoop/extensions'
require 'wukong-hadoop/configuration'

require 'wonderdog/configuration'

require 'wukong-deploy/deploy_pack'
require 'wukong-deploy/configuration'
