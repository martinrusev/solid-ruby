module Ramon
	class Log
		def self.log(message, level)
			level ||= 'notset'
			log = {"message" => message, "level" => level}
			
			log
		end
	end
end



