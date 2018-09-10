module ApplicationHelper
  def render_editor?
    controller.controller_name == 'events' && !['index', 'show'].include?(controller.action_name)
  end

  def logo_class
    return 'root' if user_signed_in?
    ''
  end
end
