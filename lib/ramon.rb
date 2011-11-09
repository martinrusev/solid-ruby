require "lib/ramon/version"
require "lib/ramon/logger"
require "lib/ramon/remote"
require "lib/ramon/exception_data"

module Ramon
	def self.log(message, level=nil)
		log_hash = Log.log(message, level)
		Remote.post('log', log_hash)
	end
	log('boo me','info')
end

