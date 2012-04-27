require 'singleton'
module Ramon
    class ZeroMQ
        include Singleton
        @@address = ""
        def self.address= address
            @@address = address
        end

        def initialize
            context = ZMQ::Context.new(1)
            @socket = context.socket(ZMQ::DEALER) 
            @socket.connect("tcp://#{@@address}")
            @socket.setsockopt(ZMQ::LINGER, 0) 
            @socket.setsockopt(ZMQ::SWAP, 25000000) # 25MB disk swap
        end

        def post(data)
            @socket.send(data, ZMQ::NOBLOCK)
        end

    end

end
