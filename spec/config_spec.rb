require 'spec_helper'

module Ramon
describe Configuration do

 it "should provide default values" do
    config = Ramon::Configuration.new
    config.port.should == 2464
    config.host.should == 'http://127.0.0.1'
  end

end
end # end module
