# Load the exception handler
# Aplicable only for Rails apps
require 'ramon'

require File.join('amon', 'integration', 'rails')   

Rails.configuration.middleware.use "Rack::RailsAmonException"
