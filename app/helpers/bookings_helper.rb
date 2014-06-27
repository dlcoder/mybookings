module BookingsHelper

  def bootstrap_class_for booking_status
    case booking_status
      when 'pending'
        return 'warning'
      when 'expired'
        return 'success'
      when 'occurring'
        return 'info'
    end
  end

end
