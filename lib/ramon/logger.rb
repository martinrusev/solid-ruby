module Ramon
	class AmonLog
		class << self
			def log(message, level)
				log = {"message" => message, "level" => level}
				log
			end
		end 
	end
end



