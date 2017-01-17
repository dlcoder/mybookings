module Mybookings
  class Booking < ActiveRecord::Base
    include Loggable

    belongs_to :user
    belongs_to :resource_type
    has_many :events , inverse_of: :booking

    accepts_nested_attributes_for :events

    delegate :email, to: :user, prefix: true
    delegate :name, to: :resource_type, prefix: true
    delegate :extension, to: :resource_type, prefix: true
    delegate :users, to: :resource_type, prefix: true

    def self.by_start_date_group_by_resource_type
      includes(:events, :resource_type).order('mybookings_resource_types.name ASC').group_by(&:resource_type)
    end

    def self.new_for_user user, params
      booking = Booking.new(params)
      booking.user = user

      booking
    end

    def delete_pending_events
      events.where(status: 0).destroy_all
    end

    def has_pending_events?
      events.pending.count > 0
    end

    def has_events?
      events.any?
    end

    def add_event event
      events << event
    end

    def add_events new_events
      new_events.each do |event|
        events << event
      end
    end
  end
end
