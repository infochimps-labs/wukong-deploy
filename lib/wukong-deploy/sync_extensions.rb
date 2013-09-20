require_relative('extensions/uses_lockfile')
require_relative('extensions/uses_file_state')
require_relative('extensions/ftp_syncer')
require_relative('extensions/prepare_syncer')
require_relative('extensions/s3_syncer')

Wukong::Load::SyncRunner.class_eval do
  include Wukong::Deploy::UsesLockfileOverride
end
if defined?(Wukong::Load::SyncAllRunner)
  Wukong::Load::SyncAllRunner.class_eval do
    include Wukong::Deploy::UsesLockfileOverride
  end
end
Wukong::Load::FTPSyncer.class_eval do
  include Wukong::Deploy::FTPSyncerOverride
end
Wukong::Load::PrepareSyncer.class_eval do
  include Wukong::Deploy::UsesFileStateOverride
  include Wukong::Deploy::PrepareSyncerOverride
end
Wukong::Load::PrepareSyncer::Handler.class_eval do
  include Wukong::Deploy::PrepareSyncerOverride::HandlerOverride
end
Wukong::Load::S3Syncer.class_eval do
  include Wukong::Deploy::S3SyncerOverride
end
