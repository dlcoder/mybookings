module Mybookings
  class EventDecorator < Draper::Decorator
    delegate_all

    def has_feedback?
      !object.feedback.blank?
    end

    def deadline_for_feedback_has_passed?
      object.end_date + MYBOOKINGS_CONFIG['deadline_for_feedback_in_days'].days < DateTime.now
    end

    def can_receive_feedback?
      object.expired? && !has_feedback? && !deadline_for_feedback_has_passed?
    end
  end
end
