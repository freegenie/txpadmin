module TxpAdmin 
  
  class ConfigNotFound < Exception
  end
  
  
  
  class Config 
    
    attr_accessor :options
    
    def initialize
      @options = self.class.parse_config_file      
    end

    def self.parse_config_file(path=".")      
    
      config_file = "#{path}/textpattern/config.php"      
      raise TxpAdmin::ConfigNotFound unless File.exists?(config_file)            
      config = `cat #{config_file}`
      txpcfg = {}
      config.gsub!("<?php", "")
      config.gsub!("?>", "")
      config.gsub!("$txpcfg", "txpcfg")
      eval(config)      
      
      txpcfg.each do |key,value|
        txpcfg[key.to_sym] = value
      end  
      
      
      # puts txpcfg.inspect
      return txpcfg      
    end
    
  end
  
end