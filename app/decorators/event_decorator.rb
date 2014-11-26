class EventDecorator < Draper::Decorator
  delegate_all

  def participate_submit_title
    if past?
      h.t('.participate_past_submit_title')
    else
      h.t('.participate_submit_title')
    end
  end

  def cancel_participation_submit_title
    if past?
      h.t('.cancel_past_participation_submit_title')
    else
      h.t('.cancel_participation_submit_title')
    end
  end

  def rendered_description
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new autolink: true, filter_html: true, hard_wrap: true)
    markdown.render(object.description).html_safe
  end

  def simple_description
    h.strip_tags(rendered_description)
  end

  def summary
    [l(object.started_at), object.place, object.title].join(' – ')
  end

  def full_description
    rendered_description +
    h.content_tag(:hr, '') +
    h.content_tag(:p, summary)
  end

  def truncated_description(length = 80)
    text = h.strip_tags(rendered_description).squish
    h.truncate(text, length: length, separator: '.')
  end
end
