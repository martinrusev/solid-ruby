require "rubygems"
require "ramon"
require "logger"

runs = 10000
http_address = 'http://127.0.0.1:2464'
http_bench = True
zeromq_bench = True
standart_bench = True


if http_bench == True
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


if zeromq_bench == True
    Ramon.configure do |config|
        config.address  = '127.0.0.1:5464'
        config.protocol = 'zeromq'
        config.logger = Logger.new("/dev/null")
    end

    start_time = Time.now
    (1..runs).each { 
        Ramon.log('test')
    }
    end_time = Time.now
    puts "ZeroMQ logging #{(end_time - start_time)} seconds"
end


if standart_bench == True
    log = Logger.new('bench.log') 
    start_time = Time.now
    (1..runs).each { 
        log.info('test')
    }
    end_time = Time.now
    puts "Standard logging #{(end_time - start_time)} seconds"
end

