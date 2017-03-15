# Require devise before rails engine to be able to override templates.
require 'devise'
require 'bootstrap3-datetimepicker-rails'

require 'mybookings/engine'

require 'bootstrap-sass'
require 'draper'
require 'fullcalendar-rails'
require 'haml'
require 'haml-rails'
require 'ice_cube'
require 'jbuilder'
require 'jquery-rails'
require 'jquery-turbolinks'
require 'js-routes'
require 'kaminari'
require 'momentjs-rails'
require 'omniauth-saml'
require 'paranoia'
require 'pundit'
require 'role_model'
require 'simple_form'
require 'turbolinks'

require_relative 'mybookings/resource_types_extensions/default_extension'

module Mybookings
end
