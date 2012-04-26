require "rubygems"
require "ramon"
require "logger"
require 'singleton'
require "zmq"

runs = 5000
http_address = 'http://127.0.0.1:2464'
http_bench = false
zeromq_bench = true
standart_bench = true

puts "Runs: #{runs}"

if http_bench == true
    Ramon.configure do |config|
        config.address  = http_address
        config.logger = Logger.new("/dev/null")
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
   
  def initialize
    @context = ZMQ::Context.new(1)
    @socket = @context.socket(ZMQ::DEALER) 
    @socket.connect("tcp://127.0.0.1:5464")
    @socket.setsockopt(ZMQ::LINGER, 0) 
  end
 
  def post(data)
    @socket.send(data, ZMQ::NOBLOCK)
  end

end

    #Ramon.configure do |config|
        #config.address  = '127.0.0.1:5464'
        #config.protocol = 'zeromq'
        #config.logger = Logger.new(STDOUT)
    #end

    start_time = Time.now
    (1..runs).each { 
        json_data = {:type => 'log', :content =>  {:message => 'zeromq test'}}
        json_data = json_data.to_json
        ZeroMQ.instance.post(json_data)
    }
    end_time = Time.now
    puts "ZeroMQ logging #{(end_time - start_time)} seconds"
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

