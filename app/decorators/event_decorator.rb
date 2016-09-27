class EventDecorator < Draper::Decorator
  delegate_all

  decorates_association :events

  def has_feedback?
    !object.feedback.nil?
  end
end
