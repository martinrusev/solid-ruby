def require_local(file)
  require File.join(File.dirname(__FILE__), 'ramon', file)
end

require_local "version"
require_local "logger"
require_local "remote"
require_local "catcher"
require_local  "exception_data"
require_local  "controller_exception_data"
require_local  "enviroment_data"

module Ramon
	def self.log(message, level=nil)
		log_hash = Log.log(message, level)
		Remote.post('log', log_hash)
	end

	def self.post(type, data)
		Remote.post(type, data)
	end
end

