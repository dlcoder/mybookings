class BookingForm
  include ActiveModel::Validations

  attr_accessor :resource_id, :start_date, :end_date

  validates :resource_id, :start_date, :end_date, presence: true

  def initialize params={}
    self.resource_id = params[:resource_id]
    self.start_date = params[:start_date]
    self.end_date = params[:end_date]
  end

  def to_key; nil; end
end
