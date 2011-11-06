require "lib/ramon/version"
require "lib/ramon/logger"
require "lib/ramon/remote"
require "lib/ramon/exception_data"

module Ramon
	def self.log(message, level=nil)
		log_hash = Log.log(message, level)
		puts log_hash
	end
end

