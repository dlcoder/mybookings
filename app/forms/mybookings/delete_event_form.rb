module Mybookings
  class DeleteEventForm
    include ActiveModel::Validations

    attr_accessor :reason

    validates :reason, presence: true

    def initialize params={}
      self.reason = params[:reason]
    end

    def to_key; nil; end
  end
end
