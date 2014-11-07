module ApplicationHelper
  def render_editor?
    controller.controller_name == 'events' && !['index', 'show'].include?(controller.action_name)
  end
end
