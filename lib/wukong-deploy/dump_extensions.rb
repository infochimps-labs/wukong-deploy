require_relative('extensions/uses_lockfile')
require_relative('extensions/uses_file_state')
Wukong::Load::DirectoryDumper.class_eval do
  include Wukong::Deploy::UsesLockfileOverride
  include Wukong::Deploy::UsesFileStateOverride
end
