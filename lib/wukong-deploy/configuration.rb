module Wukong
  [:Local, :Hadoop, :Elasticsearch].each do |mod|
    Wukong.const_get(mod).const_get(:Configuration).define(:environment, :description => "The environment to run in", :default => 'development', :flag => 'e', :env_var => 'ICS_PLATFORM_ENV')
  end
end
