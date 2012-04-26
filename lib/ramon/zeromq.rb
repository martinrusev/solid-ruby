require 'singleton'
module Ramon
    class ZeroMQ
        include Singleton
        @@address = ""
        def self.address= address
            @@address = address
        end

        def initialize
            context = ZMQ::Context.new()
            @socket = context.socket(ZMQ::DEALER) 
            @socket.connect("tcp://#{@@address}")
        end

        def post(data)
            @socket.send(data, ZMQ::NOBLOCK)
        end

    end

end
