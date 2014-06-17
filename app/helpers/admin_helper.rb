module AdminHelper

  def active_class_for controller
    'active' if params[:controller] == controller
  end

end
