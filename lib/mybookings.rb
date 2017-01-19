# Require devise before rails engine to be able to override templates.
require 'devise'
require 'bootstrap3-datetimepicker-rails'

require 'mybookings/engine'

require 'bootstrap-sass'
require 'draper'
require 'haml'
require 'haml-rails'
require 'jquery-rails'
require 'jquery-turbolinks'
require 'momentjs-rails'
require 'omniauth-saml'
require 'pundit'
require 'role_model'
require 'simple_form'
require 'turbolinks'

require_relative 'mybookings/resource_types_extensions'
require_relative 'mybookings/resource_types_extensions/base_extension'
require_relative 'mybookings/resource_types_extensions/default_extension'
require_relative 'mybookings/resource_types_extensions/default_extension/extension'
require_relative 'mybookings/resource_types_extensions_wrapper'
require_relative 'mybookings/creates_booking'


module Mybookings
end
