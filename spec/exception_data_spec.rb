require 'spec_helper'
require 'action_controller'
require 'action_controller/test_case'

module Ramon

class RamonError < StandardError 
	def backtrace
		'test'
	end
end
	
describe Ramon::ControllerExceptionData, 'with request/controller/params' do
 
	class TestController < ActionController::Base
	end

	# Only when debugging
	#after do
		#puts @json
	#end

	before :each do
		@controller = TestController.new
		@request = ActionController::TestRequest.new({'action' => 'some_action' })
		@request.stub!(:url).and_return('http://test.host/some_path?var1=abc')
		@request.stub!(:parameters).and_return({'var1' => 'abc', 'action' => 'some_action'})
		@request.stub!(:request_method).and_return(:get)
		@request.stub!(:remote_ip).and_return('1.2.3.4')
		@request.stub!(:env).and_return({'SOME_VAR' => 'abc', 'HTTP_CONTENT_TYPE' => 'text/html'})
		@request.session = {"session_data" => "some_data", "more_session_data" => "more_data"}
		@error = Ramon::RamonError.new('some message')
		data = Ramon::ControllerExceptionData.new(@error, @controller, @request)
		@hash = data.to_hash
		#@json = data.to_json
	end

	it "Captures request data" do
		request_hash = @hash['data']['request']
		request_hash['url'].should == 'http://test.host/some_path?var1=abc'
		request_hash['controller'].should == 'Ramon::TestController'
		request_hash['action'].should == 'some_action'
		request_hash['parameters'].should == {'var1' => 'abc', 'action' => 'some_action', }
		request_hash['request_method'].should == 'get'
		request_hash['remote_ip'].should == '1.2.3.4'
		request_hash['session']['data'].should == {"more_session_data" => "more_data","session_data" => "some_data"}
	end

	it "Captures exception data" do
		@hash['message'].should == 'some message'
		@hash['backtrace'].should == 'test'
		@hash['exception_class'].should == 'Ramon::RamonError'

	end

end

end # module end
