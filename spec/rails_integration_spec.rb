require "spec_helper"
require 'rack/mock'
require 'ramon/integration/rails'
require 'action_controller'

module Ramon
class RamonError < StandardError 
end

describe Rack::RailsAmonException do

  class TestingController < ActionController::Base

    def raises_something
      raise StandardError
    end
  end
    
  before(:each) do 
    @error = RamonError.new
    @app = lambda { |env| raise @error, 'error' }
    @env = Rack::MockRequest.env_for("/")    
    @env['action_controller.instance'] = TestingController.new    
  end
  
  it 'Raise the error caught in the middleware' do       
    rr = Rack::RailsAmonException.new(@app)
    Ramon::Catcher.should_receive(:handle_with_controller)
    lambda { rr.call(@env)}.should raise_error(RamonError)    
  end

end

end # Module end
