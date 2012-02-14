require 'net/http'
require 'json'
require 'zlib'
require "#{File.dirname(__FILE__)}/config"

module Ramon
class Remote
	def self.post(type, data)

		if type == 'log'
			@url = "/api/log/#{Config::app_key}"
		else
			@url = "/api/exception/#{Config::app_key}"
		end

		request = Net::HTTP::Post.new(@url, initheader = {'Content-Type' =>'application/json'})
		request.body = data.to_json

		begin
		  response = Net::HTTP.new(Config::host, Config::port).start {|http| http.request(request) }
          case response
            when Net::HTTPSuccess
              LogFactory.log.info( "#{@url} - #{response.message}")
              return response
            else
              LogFactory.log.error("#{@url} - #{response.code} - #{response.message}")
          end
        rescue Exception => e
          LogFactory.log.error(e)
        end

	end
end # class end
end # module end 

