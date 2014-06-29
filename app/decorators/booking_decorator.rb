class BookingDecorator < Draper::Decorator

  delegate_all

  def pending?
    object.start_date.future?
  end

  def expired?
    object.end_date.past?
  end

  def occurring?
    object.start_date.past? && object.end_date.future?
  end

  def has_feedback?
    !object.feedback.nil?
  end

end
