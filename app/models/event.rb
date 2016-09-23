class Event < ActiveRecord::Base
  include Loggable

  belongs_to :booking

  validates :start_date, :end_date, presence: true
  validate :dates_range
  validate :dates_in_the_future, :dates_ovelap, on: :create

  private

  def dates_in_the_future
    unless start_date.nil?
      errors.add(:start_date, I18n.t('errors.messages.event.start_date_in_the_past')) if start_date.past?
    end

    unless end_date.nil?
      errors.add(:end_date, I18n.t('errors.messages.event.end_date_in_the_past')) if end_date.past?
    end
  end

  def dates_range
    unless start_date.nil? or end_date.nil?
      if end_date <= start_date
        errors.add(:start_date, I18n.t('errors.messages.event.start_date_greater_than_end_date'))
        errors.add(:end_date, I18n.t('errors.messages.event.end_date_smaller_than_start_date'))
      end
    end
  end

  def dates_ovelap
    unless start_date.nil? or end_date.nil? or self.booking.nil?
      resource = self.booking.resource
      start_date = self.start_date - MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes
      end_date = self.end_date + MYBOOKINGS_CONFIG['extensions_trigger_frequency'].minutes

      overlapped_events = Resource.joins(bookings: :events).where('(resources.id = ?) AND ((? >= events.start_date AND ? <= events.end_date) OR (? >= events.start_date AND ? <= events.end_date))', resource.id, start_date, start_date, end_date, end_date)
      errors.add(:base, I18n.t('errors.messages.booking.overlap')) if overlapped_events.any?
    end
  end

end
