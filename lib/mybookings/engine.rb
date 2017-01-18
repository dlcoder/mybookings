module Mybookings
  class Engine < ::Rails::Engine
    isolate_namespace Mybookings

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
