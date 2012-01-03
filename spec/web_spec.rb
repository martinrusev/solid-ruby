require 'spec_helper'

# Works only when the Amon application is started
describe 'Web app test' do

	it 'Test logging' do
		Ramon.log([1,2,3,4]).response.code.should == "200"
		Ramon.log({:test => 'data', :more_test => 'more_data'}).response.code.should == "200"
	end	
	
	it 'Test logging with multiple tags' do
		Ramon.log("test", ['debug', 'benchmark']).response.code.should == "200"
		Ramon.log({:test => 'data', :more_test => 'more_data'}, ['info','warning','user']).response.code.should == "200"
	end


	it 'Test Exceptions' do
		Ramon.post('exception', {:url => 'test', :exception_class => 'test_me'}).response.code.should == "200"
	end

end

