require 'ramon'
require 'rails'

module Ramon
class Railtie < Rails::Railtie
    initializer "amon.middleware" do |app|
        app.config.middleware.use "Rack::RailsAmonException"
    end


    config.after_initialize do
      Ramon.configure do |config|
        config.logger           ||= ::Rails.logger
        config.environment_name ||= ::Rails.env
        config.project_root     ||= ::Rails.root
        config.framework        = "Rails: #{::Rails::VERSION::STRING}"
      end
    end

end # class end
end # module end

