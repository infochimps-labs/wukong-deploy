require_relative('extensions/hadoop_invocation_override')
Wukong::Hadoop::HadoopRunner.class_eval { include Wukong::Deploy::HadoopInvocationOverride }
