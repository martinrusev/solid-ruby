require 'spec_helper'

module Ramon
describe Log do
	
	it "should return a hash with level - debug and message - test" do
		@log = Log.log('test', 'debug')
		@log.should == {"level" => "debug", "message" => "test"}
	end

	it "should return a hash with level - info and message - test" do
		@log = Log.log('test', 'info')
		@log.should == {"level" => "info", "message" => "test"}
	end
	
	it "should return a hash with level - notset and message - test" do
		@log = Log.log('test')
		@log.should == {"level" => "notset", "message" => "test"}
	end
	
	it "should return a hash with level - notset and a message hash" do
		@log = Log.log({:test => "test value", :more => "even more value"})
		@log.should == {"level" => "notset", "message"=>{:more=>"even more value", :test=>"test value"}}
	end
	
	it "should return a hash with level - debug and a message hash" do
		@log = Log.log({:test => "test value", :more => "even more value"},'debug')
		@log.should == {"level" => "debug", "message"=>{:more=>"even more value", :test=>"test value"}}
	end
	
	it "should return a hash with level - notset and a message array" do
		@log = Log.log([1,2,3,4])
		@log.should == {"level" => "notset", "message"=>[1,2,3,4]}
	end

end
end
