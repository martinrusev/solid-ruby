require 'net/http'
require 'json'
require 'zlib'

module Ramon
    class Sender
        def initialize(options = {})
            [ :address, 
                :protocol,
                :secret_key
            ].each do |option|
                instance_variable_set("@#{option}", options[option])
            end
        end

        attr_reader :address, :protocol, :secret_key

        def log(level, message)
            logger.send level, ''+ message
		end


        def logger
            Ramon.logger
        end


        def url
            URI.parse("#{address}/api/")
        end

        def post_http(type, data = {})
            
            if type == 'log'
                @url = "#{url}log/#{secret_key}"
            else
                @url = "#{url}exception/#{secret_key}"
            end

            request = Net::HTTP::Post.new(@url, initheader = {'Content-Type' =>'application/json'})
            request.body = data.to_json

            begin
                response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
                
                case response
                when Net::HTTPSuccess
                    log :info, "#{@url} - #{response.message}"
                    return response
                else
                    log :error, "#{@url} - #{response.code} - #{response.message}"
                end
            rescue Exception => e
                log :error, "[Ramon::Sender#post] Cannot send data to #{@url} Error: #{e.class} - #{e.message}"
                nil 
            end
        end

        def post_zeromq(type, data = {})
            if defined?(ZMQ)
                json_data = {:type => type, :content =>  data}
                
                if secret_key
                    json_data['secret_key'] = secret_key
                end

                json_data = json_data.to_json

                ZeroMQ.address = address
                ZeroMQ.instance.post(json_data)
            else
                puts "ZeroMQ is not installed. You can install it with `gem install zmq`"
            end
        end

        def post(type, data)
            if protocol == 'zeromq'
                post_zeromq(type, data)
            elsif protocol == 'http'
                post_http(type, data)
            end
        end

    end # Class end 
end # Module end
