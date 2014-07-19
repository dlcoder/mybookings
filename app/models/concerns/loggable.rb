module Loggable
  extend ActiveSupport::Concern

  included do
    after_create :notify_record_created
    after_update :notify_record_updated
  end

  private

  def notify_record_created
    ActiveSupport::Notifications.instrument('mybookings_info.record_created', object: self)
  end

  def notify_record_updated
    ActiveSupport::Notifications.instrument('mybookings_info.record_updated', object: self)
  end
end
