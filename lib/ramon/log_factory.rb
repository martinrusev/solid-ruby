require 'logger'
require 'date'

module Ramon
class Log
	
	def self.log(message, tags=nil)
		tags ||= 'notset'
		log = {"message" => message, "tags" => tags}
		
		log
	end

end # class end

# Used internally
class LogFactory

	def self.log
		@logger ||= define_internal_logger
	end
	
	private
	def self.define_internal_logger
        log_dir = File.join(Config.application_root, 'log')
        Dir.mkdir(log_dir) unless File.directory?(log_dir)
        log_path = File.join(log_dir, "/ramon.log")
        
		log = Logger.new(log_path)
        log.level = Logger::INFO

		log.formatter = proc do |severity, datetime, progname, msg|
			"#{datetime}: #{msg} -- #{severity}\n"
		end

		log
	end

end # class end

end # module end





