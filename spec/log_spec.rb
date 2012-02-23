require 'spec_helper'

module Ramon
describe "log" do
	
	it "should return a hash with tags - debug and message - test" do
		@log = Ramon.format_log('test', 'debug')
		@log.should == {"tags" => "debug", "message" => "test"}
	end

	it "should return a hash with tags - info and message - test" do
		@log = Ramon.format_log('test', 'info')
		@log.should == {"tags" => "info", "message" => "test"}
	end
	
	it "should return a hash with tags - notset and message - test" do
		@log = Ramon.format_log('test')
		@log.should == {"tags" => "notset", "message" => "test"}
	end
	
	it "should return a hash with tags - notset and a message hash" do
		@log = Ramon.format_log({:test => "test value", :more => "even more value"})
		@log.should == {"tags" => "notset", "message"=>{:more=>"even more value", :test=>"test value"}}
	end
	
	it "should return a hash with tags - debug and a message hash" do
		@log = Ramon.format_log({:test => "test value", :more => "even more value"},'debug')
		@log.should == {"tags" => "debug", "message"=>{:more=>"even more value", :test=>"test value"}}
	end
	
	it "should return a hash with tags - notset and a message array" do
		@log = Ramon.format_log([1,2,3,4])
		@log.should == {"tags" => "notset", "message"=>[1,2,3,4]}
	end

	it "should return an array with tags - debug, benchmark and a message string" do
		@log = Ramon.format_log("test", ["debug", "benchmark"])
		@log.should == {"tags" => ["debug", "benchmark"], "message"=>"test"}
	end

end
end
