$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem"s version:
require "mybookings/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mybookings"
  s.version     = Mybookings::VERSION
  s.authors     = ["Jesús Manuel García Muñoz"]
  s.email       = ["jesus@deliriumcoder.com"]
  s.homepage    = "https://github.com/dlcoder/mybookings"
  s.summary     = "A web based system for resource booking in companies or institutions"
  s.description = "MyBookings is a web based system for resource booking in companies or institutions that manages different kinds of resources to lend it to a community of users. MyBookings is built with the Ruby on Rails framework, and therefore can be executed in any typical Ruby web server."
  s.license     = "AGPLv3"

  s.files       = `git ls-files`.split("\n")
  s.test_files  = Dir["spec/**/*"]

  s.add_dependency "rails",                           "~> 5.2.0"
  s.add_dependency "bootstrap-sass",                  "~> 3.3.6"
  s.add_dependency "bootstrap3-datetimepicker-rails", "~> 4.17.47"
  s.add_dependency "coffee-rails",                    "~> 4.2.2"
  s.add_dependency "devise",                          "~> 4.7.0"
  s.add_dependency "draper",                          "~> 3.0"
  s.add_dependency "fullcalendar-rails",              "~> 3.1"
  s.add_dependency "haml-rails",                      "~> 1.0"
  s.add_dependency "ice_cube",                        "~> 0.15"
  s.add_dependency "jbuilder",                        "~> 2.9.1"
  s.add_dependency "jquery-rails",                    "~> 4.3.5"
  s.add_dependency "js-routes",                       "~> 1.4.9"
  s.add_dependency "kaminari",                        "~> 1.1.1"
  s.add_dependency "momentjs-rails",                  ">= 2.20.1"
  s.add_dependency "omniauth-saml",                   "~> 1.10.1"
  s.add_dependency "paranoia",                        "~> 2.2"
  s.add_dependency "pundit",                          "~> 2.1.0"
  s.add_dependency "role_model",                      "~> 0.8.2"
  s.add_dependency "sass-rails",                      ">= 3.2"
  s.add_dependency "simple_form",                     "~> 5.0.0"
  s.add_dependency "turbolinks",                      "~> 5.0"
  s.add_dependency "uglifier",                        ">= 1.3.0"
end
