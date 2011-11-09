require 'net/http'
require 'json'
require 'zlib'
require "#{File.dirname(__FILE__)}/config"

module Ramon
	class Remote
		def self.post(type, data)

			if type == 'log':
				@url = '/api/log'
			else
				@url = '/api/exception'
			end
			puts data

			req = Net::HTTP::Post.new(@url, initheader = {'Content-Type' =>'application/json'})
			#req.body = Zlib::Deflate.deflate(data.to_json, Zlib::BEST_SPEED)
			req.body = data.to_json
			response = Net::HTTP.new(Config::host, Config::port).start {|http| http.request(req) }
			puts "Response #{response.code} #{response.message}: #{response.body}"
		end
	end # class end
end # module end 
