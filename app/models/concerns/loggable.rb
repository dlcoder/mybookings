module Loggable
  extend ActiveSupport::Concern

  included do
    after_create :notify_record_created
    after_update :notify_record_updated

    def log_for_record_created name, datetime
      Rails.logger.info "#{name} - New #{self.class.name} (#{self.id}) at #{datetime}."
    end

    def log_for_record_updated name, datetime
      Rails.logger.info "#{name} - #{self.class.name} (#{self.id}) updated at #{datetime}."
    end
  end


  private

  def notify_record_created
    ActiveSupport::Notifications.instrument('mybookings_info.record_created', object: self)
  end

  def notify_record_updated
    ActiveSupport::Notifications.instrument('mybookings_info.record_updated', object: self)
  end
end
