require 'json'

module Ramon
class Config
class ConfigurationException < StandardError; end
	
	class << self
		DEFAULTS = {
			:host => '127.0.0.1',
			:port => 2464
		}

		def load
			config_file ||= "/etc/amon.conf"

			if File.file?(config_file)
				begin
					f = File.read(config_file)
					config = JSON.parse(f)

					@app_key = config['application_key'] unless config['application_key'].nil?
					@port = config['web_app']['port'].to_i unless config['web_app']['port'].nil?
					@host = config['web_app']['host'].to_s unless config['web_app']['host'].nil?

				  rescue Exception => e
					raise ConfigurationException.new("Unable to load configuration file: #{config_file}")
				  end
			else
			  puts "Amon::Config.load - /etc/amon.conf not found"
			end
		end

		def port
			@port ||= DEFAULTS[:port]
		end
		
		def host
			@host ||= DEFAULTS[:host]
		end

	end # self end
	load
end # Config end 
end # Module end
