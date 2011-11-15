require 'ramon'
require 'rails'

module Ramon
class Railtie < Rails::Railtie
    initializer "amon.middleware" do |app|
        app.config.middleware.use "Rack::RailsAmonException"
    end
end
end

