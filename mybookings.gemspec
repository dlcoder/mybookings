$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mybookings/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mybookings"
  s.version     = Mybookings::VERSION
  s.authors     = ["Jesús Manuel García Muñoz"]
  s.email       = ["jesus@deliriumcoder.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Mybookings."
  s.description = "TODO: Description of Mybookings."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency "sqlite3"
end
