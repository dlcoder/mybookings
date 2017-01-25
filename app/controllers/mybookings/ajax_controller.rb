module Mybookings
  class AjaxController < ::ActionController::Base
    def events
      @events = Event.all
    end
  end
end
