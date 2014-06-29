module BackendHelper

  def active_class_for controller
    'active' if params[:controller] == controller
  end

  def resource_tr_class resource
    'danger' if resource.disabled?
  end

  def bookings_counters_for resource
    expired_bookings = resource.expired_bookings_count
    expired = t('.expired', expired_bookings: expired_bookings)
    expired_formatted = "<span class='label label-#{bootstrap_class_for(t('bookings.statuses.expired'))}'>#{expired}</span>"

    pending_bookings = resource.pending_bookings_count
    pending = t('.pending', pending_bookings: pending_bookings) if pending_bookings > 0
    pending_formatted = "<span class='label label-#{bootstrap_class_for(t('bookings.statuses.pending'))}'>#{pending}</span>"

    occurring_bookings = resource.occurring_bookings_count
    occurring = t('.occurring', occurring_bookings: occurring_bookings) if occurring_bookings > 0
    occurring_formatted = "<span class='label label-#{bootstrap_class_for(t('bookings.statuses.occurring'))}'>#{occurring}</span>"

    "#{expired_formatted} #{pending_formatted} #{occurring_formatted}".html_safe
  end

  def roles_for user
    user.role_symbols.join(", ")
  end

end
