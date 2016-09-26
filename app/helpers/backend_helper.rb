module BackendHelper
  def active_class_for controller
    'active' if params[:controller] == controller
  end

  def resource_tr_class resource
    'danger' if resource.disabled?
  end

  def bookings_counters_for resource
    expired_events = resource.expired_events_count
    expired = t('.expired', expired_events: expired_events)
    expired_formatted = "<span class='label label-#{bootstrap_class_for('expired')}'>#{expired}</span>"

    pending_events = resource.pending_events_count
    pending = t('.pending', pending_events: pending_events) if pending_events > 0
    pending_formatted = "<span class='label label-#{bootstrap_class_for('pending')}'>#{pending}</span>"

    occurring_events = resource.occurring_events_count
    occurring = t('.occurring', occurring_events: occurring_events) if occurring_events > 0
    occurring_formatted = "<span class='label label-#{bootstrap_class_for('occurring')}'>#{occurring}</span>"

    "#{expired_formatted} #{pending_formatted} #{occurring_formatted}".html_safe
  end

  def roles_for user
    user.role_symbols.join(", ")
  end

  def available_resource_types_extensions
    extensions = ResourceTypesExtensions.constants
    extensions.delete(:BaseExtension)

    extensions
  end
end
