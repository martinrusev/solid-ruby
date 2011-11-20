module Ramon
class Log
	def self.log(message, level=nil)
		level ||= 'notset'
		log = {"message" => message, "level" => level}
		
		log
	end
end # class end
end # module end



