class BookingDecorator < Draper::Decorator

  delegate_all

  def has_feedback?
    !object.feedback.nil?
  end

end
