require_relative('extensions/storm_invocation_override')
Wukong::Storm::StormRunner.class_eval { include Wukong::Deploy::StormInvocationOverride }
