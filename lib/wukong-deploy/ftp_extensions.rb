require_relative('extensions/ftp_vayacondios')
Wukong::Load::FTP::FTPSource.class_eval { include Wukong::Deploy::FTP::VayacondiosMethods }
Wukong::Load::FTPRunner.class_eval      { include Wukong::Deploy::FTP::VayacondiosHooks   }
