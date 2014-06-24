module AdminHelper

  def active_class_for controller
    'active' if params[:controller] == controller
  end

  def resource_tr_class resource
    class_base = "resource-#{resource.id}"

    if resource.disabled?
      "#{class_base} resource-disabled danger"
    else
      "#{class_base} resource-enabled"
    end
  end

  def roles_for user
    user.role_symbols.join(", ")
  end

end
