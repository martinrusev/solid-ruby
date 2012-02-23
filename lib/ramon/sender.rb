require 'net/http'
require 'json'
require 'zlib'

module Ramon
    class Sender
        def initialize(options = {})
            [ :host, 
                :port, 
                :app_key,
                :secret
            ].each do |option|
                instance_variable_set("@#{option}", options[option])
            end
        end


        attr_reader :host,
            :port,
            :app_key,
            :secret

        def log(level, message)
            logger.send level, '** Amon '+ message
		end


        def logger
            Ramon.logger
        end


        def url
            URI.parse("#{host}:#{port}/api/")
        end

        def post(type, data)

            if type == 'log'
                @url = "#{url}log/#{app_key}"
            else
                @url = "#{url}exception/#{app_key}"
            end

            request = Net::HTTP::Post.new(@url, initheader = {'Content-Type' =>'application/json'})
            request.body = data.to_json

            begin
                response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
                case response
                when Net::HTTPSuccess
                    log :error, "#{@url} - #{response.message}"
                    return response
                else
                    log :error, "#{@url} - #{response.code} - #{response.message}"
                end
            rescue Exception => e
                log :error, "[Ramon::Sender#post] Cannot send data to #{@url} Error: #{e.class} - #{e.message}"
                nil 
            end

        end

    end # Class end 
end # Module end
