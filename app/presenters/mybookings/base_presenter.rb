require 'delegate'

module Mybookings
  class BasePresenter < SimpleDelegator
    def model
      __getobj__
    end
  end
end
