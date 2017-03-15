module Mybookings
  class StatisticsForm
    include ActiveModel::Validations

    attr_accessor :resource_type_id

    validates :resource_type_id, presence: true

    def initialize params={}
      self.resource_type_id = params[:resource_type_id]
    end

    def to_key; nil; end
  end
end
