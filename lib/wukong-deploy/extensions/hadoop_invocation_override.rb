module Wukong
  module Deploy
    module HadoopInvocationOverride
      def params_to_pass
        Deploy.pre_deploy_settings
      end
    end
  end
end


    
    
