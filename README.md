## Install

You can install the Ruby client with <code>sudo gem install ramon</code>

## Configuration


  require 'rubygems' # Only if your app throws load error 
	require 'ramon'
	require "logger"

	Ramon.configure do |config|
	    config.address  = 'http://127.0.0.1:2464'
	    config.secret_key = 'secret key from /etc/amonlite.conf'
	    config.logger = Logger.new(STDOUT)
	end

## Usage


### Logging

You can use the logging module in any Ruby application.

	# message - string, hash or array
	# tags - string or array
	Ramon.log(message, tags)

	# Will still work and in the web interface you will see these logs with level 'unset'
	Ramon.log(message)

	# Log hashes - useful for post data, benchmarks, user events or parts of the application 
	# where printing to the terminal doesn't work
	Ramon.log({:first_name => "John", :last_name => "Dev", :age => 29)

	# You can log arrays as well
	Ramon.log(['data', 'more data'])

	# Tagged logging
	Ramon.log(message, ['info','development'])



### Exception handling


At the moment the exception handling module is working only with Rails. Support for Sinatra is in the works.
In the meantime you can easily add support for your framework of choice, following the example below:
		

	require 'ramon'

	class ExceptionData 

		def initialize(exception, name=nil)
		  @exception = exception
		  @name = name
		end

		def to_hash

		  hash = {  
			  'exception_class' => @exception.class.to_s,
			  'message' => @exception.message,
			  'backtrace' =>  @exception.backtrace, 
			  'url' => '',
			  'data' => {} 
		  }

		  hash['data'].merge!(extra_stuff)
		end


	class Catcher

		  def self.handle(exception, name=nil)
			  data = ExceptionData.new(exception, name)
			  Ramon.post('exception', data.to_hash)
		  end
	end


For a real world working example you can check the source code for the Rails exception handler at 
[https://github.com/martinrusev/ramon](https://github.com/martinrusev/ramon).

The example above uses the code from these files:

	/lib/ramon/exception_data.rb 
	/lib/ramon/catcher.rb 
	


## Rails

Amon supports only Rails 3. You can capture exceptions and log data from your Rails application
by adding <code>gem 'ramon'</code> to your Gemfile and running <code>bundle update</code>
after that. 
<br/><br/>
By default Ramon sends the data to <code>http://127.0.0.1:2464</code>, to change these values 
add a <code>ramon.rb</code> file in 
<code>rails_root/config/initializers</code>


	# rails_project/config/initializers/ramon.rb
	Ramon.configure do |config| 
	    config.address  = 'http://127.0.0.1:2464'
	    config.secret_key = 'secret key from /etc/amonlite.conf'
	end


## Bugs

If you find a bug in the ruby client, you can use the the github issues page to report it: 
<a href='https://github.com/martinrusev/ramon/issues'>https://github.com/martinrusev/ramon/issues</a> 


## Meta

The Ruby client is hosted on [Github](https://github.com/martinrusev/ramon)


