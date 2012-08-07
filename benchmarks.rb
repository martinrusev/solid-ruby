require "rubygems"
require "bundler/setup"
require "ramon"
require "logger"
require 'singleton'
require "zmq"

require 'net/http'

runs = 100
http_address = "http://127.0.0.1:2465"
http_bench = true
zeromq_bench = false
standart_bench = false

puts "Runs: #{runs}"


if http_bench == true
    Ramon.configure do |config|
        config.address  = http_address
        config.secret_key = "u6ljlx2glnf8xq45ut1etkpxghmjpe3e"
        config.logger = Logger.new(STDOUT)
    end

    start_time = Time.now
    (1..runs).each { 
        Ramon.log('test')
    }
    end_time = Time.now
    puts "HTTP logging #{(end_time - start_time)} seconds"
end


if zeromq_bench == true

class ZeroMQ
  include Singleton
   
  @@address = ""
  def self.address= address
    @@address = address
  end

  def initialize
    @context = ZMQ::Context.new(1)
    @socket = @context.socket(ZMQ::DEALER) 
    @socket.connect("tcp://#{@@address}")
    @socket.setsockopt(ZMQ::LINGER, 0) 
    @socket.setsockopt(ZMQ::SWAP, 25000000) # 25MB disk swap
  end

  def post(data)
    @socket.send(data, ZMQ::NOBLOCK)
  end

end

    #start_time = Time.now
    #(1..runs).each { 
        #json_data = {:type => 'log', :content =>  {:message => 'zeromq test'}}
        #json_data = json_data.to_json
        #ZeroMQ.address = '127.0.0.1:5464'
        #ZeroMQ.instance.post(json_data)
    #}
    #end_time = Time.now
    #puts "ZeroMQ logging #{(end_time - start_time)} seconds"

    Ramon.configure do |config|
        config.address  = '127.0.0.1:5464'
        config.protocol = 'zeromq'
        config.logger = Logger.new(STDOUT)
    end
    
    start_time = Time.now
    (1..runs).each { 
        Ramon.log('ramon zeromq test')
    }
    end_time = Time.now
    puts "Ramon ZeroMQ logging #{(end_time - start_time)} seconds"


end


if standart_bench == true
    log = Logger.new('bench.log') 
    start_time = Time.now
    (1..runs).each { 
        log.info('test')
    }
    end_time = Time.now
    puts "Standard logging #{(end_time - start_time)} seconds"
end

