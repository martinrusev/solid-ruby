require 'net/http'
require 'json'
require 'zlib'
begin
  require 'zmq'
rescue LoadError
end

module Ramon
    class Sender
        def initialize(options = {})
            [ :address, 
                :protocol,
                :app_key,
                :secret
            ].each do |option|
                instance_variable_set("@#{option}", options[option])
            end
        end

        attr_reader :address, 
            :protocol,
            :app_key,
            :secret

        def log(level, message)
            logger.send level, '** Amon '+ message
		end


        def logger
            Ramon.logger
        end


        def url
            URI.parse("#{address}/api/")
        end

        def post_http(type, data = {})
            
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
                context = ZMQ::Context.new()
                socket = context.socket(ZMQ::DEALER) 
                socket.connect("tcp://#{address}")
                socket.setsockopt(ZMQ::LINGER,0) 
                json_data = {:type => type,
                            :content =>  data}
                if app_key
                    json_data['app_key'] = app_key
                end

                json_data = json_data.to_json

                socket.send(json_data, ZMQ::NOBLOCK)
                socket.close()
                context.close()
                true
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
