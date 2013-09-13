require_relative('extensions/load')
require_relative('extensions/ftp')
Wukong::Load::FTPRunner.class_eval          { include Wukong::Deploy::UsesLockfileOverride       }
Wukong::Load::FTP::FTPSource.class_eval     { include Wukong::Deploy::FTP::VayacondiosMethods    }
Wukong::Load::FTPRunner.class_eval          { include Wukong::Deploy::FTP::VayacondiosHooks      }
Wukong::Load::FTP::MirroredFiles.class_eval { include Wukong::Deploy::FTP::MirroredFilesOverride }
