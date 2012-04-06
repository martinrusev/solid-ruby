require 'spec_helper'
require "logger"

module Ramon
    # Works only when the AmonMQ server is started
    describe 'Web app zeromq test' do

        it 'Test ZeroMQ logging' do

            Ramon.configure do |config|
                config.address  = '127.0.0.1:5464'
                config.protocol = 'zeromq'
                config.logger = Logger.new(STDOUT)
            end
            
            Ramon.log([1,2,3,4]).should == true
            Ramon.log({:test => 'zeromq data', :more_test => 'more zeromq data'}).should == true
        end	

        it 'Test logging with multiple tags' do
            Ramon.log("test zeromq", ['debug', 'benchmark']).should == true
            Ramon.log({:test => 'data', :more_test => 'more_data'}, ['info','warning','user']).should == true
        end


        it 'Test Exceptions' do
            Ramon.post('exception', {:url => 'test', :exception_class => 'test_me zeromq'}).should == true
        end

    end
end 

