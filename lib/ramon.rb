def require_local(file)
    require File.join(File.dirname(__FILE__), "ramon", file)
end

require_local  "version"
require_local  "sender"
require_local  "configuration"
require_local  "catcher"
require_local  "exception_data"
require_local  "controller_exception_data"
require_local  "enviroment_data"

require_local  "integration/rails" if defined?(Rails)
require_local  "railtie" if defined?(Rails)

module Ramon

    class << self

        # The sender object is responsible for delivering formatted data to the Amon server.
        attr_accessor :sender

        # Ramon configuration object. Must act like a hash and return sensible
        # values for all configuration options. 
        attr_writer :configuration

        # Call this method to modify defaults in your initializers.
        #
        # @example
        #   Ramon.configure do |config|
        #     config.app_key = '1234567890abcdef'
        #     config.host  = 'http://127.0.0.1'
        #     config.port  = 2464
        #   end
        def configure()
            yield(configuration)
            self.sender = Sender.new(configuration)
            self.sender
        end

        # The configuration object.
        # @see Ramon.configure
        def configuration
            @configuration ||= Configuration.new
        end


        # Look for the Rails logger currently defined
        def logger
            self.configuration.logger
        end

        def format_log(message, tags=nil)
            tags ||= 'notset'
            log = {"message" => message, "tags" => tags}
            log 
        end

        def log(message, tags=nil)
            log = format_log(message, tags)
            sender.post('log', log)
        end

        def post(type, data)
            sender.post(type, data)
        end

    end # self end 

end # module end

