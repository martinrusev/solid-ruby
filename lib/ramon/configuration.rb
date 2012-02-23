module Ramon
    class Configuration
        class ConfigurationException < StandardError; end
        OPTIONS = [:app_key, :host, :port, :secret,
            :environment_name, :framework, :project_root].freeze

        # The Aplication key. Only in Amon Plus.
        attr_accessor :app_key

        # Secret key, used for securely logging in the normal Amon version
        attr_accessor :secret

        # The host to connect to (defaults to 127.0.0.1).
        attr_accessor :host

        # The port on which your Amon instance runs. Defaults to 2464
        attr_accessor :port

        # The name of the environment the application is running in
        attr_accessor :environment_name

        # The path to the project in which the error occurred, such as the RAILS_ROOT
        attr_accessor :project_root

        # The framework Ramon is configured to use
        attr_accessor :framework

        # The logger used by Amon
        attr_accessor :logger

        def initialize
            @host                     = 'http://127.0.0.1'
            @port                     = 2464
            @app_key                  = ''
            @secret                   = ''
            @framework                = 'Standalone'
        end


        # Allows config options to be read like a hash
        #
        # @param [Symbol] option Key for a given attribute
        def [](option)
            send(option)
        end

        # Returns a hash of all configurable options
        def to_hash
            OPTIONS.inject({}) do |hash, option|
                hash.merge(option.to_sym => send(option))
            end
        end

        # Returns a hash of all configurable options merged with +hash+
        #
        # @param [Hash] hash A set of configuration options that will take precedence over the defaults
        def merge(hash)
            to_hash.merge(hash)
        end


    end # Class end
end # Module end
