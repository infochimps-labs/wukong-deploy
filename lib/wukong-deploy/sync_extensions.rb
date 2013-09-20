require_relative('extensions/uses_lockfile')
require_relative('extensions/uses_file_state')
require_relative('extensions/ftp_syncer')
require_relative('extensions/archive_syncer')
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
Wukong::Load::ArchiveSyncer.class_eval do
  include Wukong::Deploy::UsesFileStateOverride
  include Wukong::Deploy::ArchiveSyncerOverride
end
Wukong::Load::ArchiveSyncer::Handler.class_eval do
  include Wukong::Deploy::ArchiveSyncerOverride::HandlerOverride
end
Wukong::Load::S3Syncer.class_eval do
  include Wukong::Deploy::S3SyncerOverride
end
