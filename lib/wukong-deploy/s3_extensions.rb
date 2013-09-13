require_relative('extensions/load')
Wukong::Load::S3Runner.class_eval          { include Wukong::Deploy::UsesLockfileOverride       }
