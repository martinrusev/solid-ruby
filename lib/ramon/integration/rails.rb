require 'rubygems'
require 'rack'

module Rack  
  class RailsAmonException    

    def initialize(app)
      @app = app
    end    
    
    def call(env)
      begin
        body = @app.call(env)
      rescue Exception => e
        Catcher.handle_with_controller(e,env['action_controller.instance'], Rack::Request.new(env))
        raise
      end

      body
    end      
  end
end
