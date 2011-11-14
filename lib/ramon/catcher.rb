class Catcher
	class << self
	  
	  def handle_with_controller(exception, controller=nil, request=nil)
		  data = ControllerExceptionData.new(exception, controller, request)
		  puts data.to_json
		  Ramon.post('exception', data)
		  #Remote.error(data)
	  end
	  
	  def handle_with_rack(exception, environment, request) 
		  data = RackExceptionData.new(exception, environment, request)
		  #Remote.error(data)
	  end

	  def handle(exception, name=nil)
		  data = ExceptionData.new(exception, name)
		  #Remote.error(data)
	  end

	end
end
