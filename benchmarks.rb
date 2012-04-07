require "rubygems"
require "ramon"
require "logger"

Ramon.configure do |config|
    config.address  = 'http://127.0.0.1:2465'
    config.logger = Logger.new("/dev/null")
end

start_time = Time.now
(1..1000).each { 
    Ramon.log('test')
}
end_time = Time.now
puts "HTTP logging #{(end_time - start_time)} seconds"


Ramon.configure do |config|
    config.address  = '127.0.0.1:5464'
    config.protocol = 'zeromq'
    config.logger = Logger.new("/dev/null")
end

start_time = Time.now
(1..1000).each { 
    Ramon.log('test')
}
end_time = Time.now
puts "ZeroMQ logging #{(end_time - start_time)} seconds"


log = Logger.new('bench.log') 
start_time = Time.now
(1..1000).each { 
    log.info('test')
}
end_time = Time.now
puts "Standard logging #{(end_time - start_time)} seconds"

