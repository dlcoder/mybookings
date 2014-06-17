module ResourcesHelper

  def resource_tr_class resource
    class_base = "resource-#{resource.id}"

    if resource.disabled?
      "#{class_base} resource-disabled danger"
    else
      "#{class_base} resource-enabled"
    end
  end

end
