require 'spec_helper'

module Ramon
describe Configuration do

 it "should provide default values" do
    config = Ramon::Configuration.new
    config.address.should == 'http://127.0.0.1:2464'
    config.protocol.should == 'http'
  end

end
end # end module
