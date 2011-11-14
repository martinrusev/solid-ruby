require 'ramon'

require File.join('amon', 'integration', 'rails')   

Rails.configuration.middleware.use "Rack::RailsAmonException"
