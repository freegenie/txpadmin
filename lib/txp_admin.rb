module TxpAdmin 
  
  class ConfigNotFound < Exception
  end
  
  class RestoreFileNotFound < Exception 
  end
    
  class MysqlConnect 
    
    @@config = nil 
        
    def self.config 
      return @@config unless @@config.nil? 
      @@config = TxpAdmin::Config.new.options       
      # puts @@config.inspect
      # FIXME: how do a mysql alias evaluated in exec? 
      # Example: mysql='mysql --socket=/Applications/xampp/xamppfiles/var/mysql/mysql.sock'    
      @@config[:host] = @@config[:host] == "localhost" ? "127.0.0.1" : @@config[:host]        
      @@password = @@config[:pass].strip != "" ? " -p#{@@config[:pass]}" : ""
      @@config
    end
    
    def self.dump_command
      c = "mysqldump #{self.command_options}"       
    end    
    
    def self.backup 
      command = "#{self.dump_command} | gzip -c > txpadmin_backup_#{Time.now.to_i}.dump.gz"
      puts "executing: #{command}"      
      exec(command)
    end
    
    def self.restore(filename) 
      raise RestoreFileNotFound unless File.exists?(filename)      
      command = "gunzip -c #{filename} | #{self.commandline}"
      exec(command)
    end
    
    def self.command_options 
      " -u#{self.config[:user]} #{@@password} -h#{self.config[:host]} #{self.config[:db]}"
    end
    
    def self.commandline 
      c = "mysql #{self.command_options}"
    end
    
    def self.execute(sql_command)      
      puts "executing SQL: #{sql_command}"
      exec("#{commandline} -e \"#{sql_command}\" ")
    end
    
    def self.console       
      # puts "executing command: #{commandline}"          
      exec(commandline)
    end
    
  end
  
  class Config 
    
    attr_accessor :options
    
    def initialize
      @options = self.class.parse_config_file      
    end

    def self.parse_config_file(path=".")          
      config_file = "#{path}/textpattern/config.php"      
      raise TxpAdmin::ConfigNotFound unless File.exists?(config_file)            
      
      config_lines = File.readlines(config_file)
      config_to_eval = String.new 
      
      config_lines.each do |line|
         config_to_eval << line if (line.include? "$txpcfg" and !line.include? "define")
      end
            
      config_to_eval.gsub!("$txpcfg", "txpcfg") 
      txpcfg = {}
      eval(config_to_eval)            
      txpcfg.each do |key,value|
        txpcfg[key.to_sym] = value
      end  
            
      # puts txpcfg.inspect
      return txpcfg      
    end
    
  end
  
end