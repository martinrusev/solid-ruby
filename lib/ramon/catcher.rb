module Ramon
class Catcher
	class << self
	  
	  def handle_with_controller(exception, controller=nil, request=nil)
		  data = ControllerExceptionData.new(exception, controller, request)
		  Ramon.post('exception', data)
	  end
	  
	  def handle_with_rack(exception, environment, request) 
		  data = RackExceptionData.new(exception, environment, request)
	  end

	  def handle(exception, name=nil)
		  data = ExceptionData.new(exception, name)
	  end

	end
end # class end
end # module end
