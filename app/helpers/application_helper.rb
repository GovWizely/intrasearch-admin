module ApplicationHelper
  TRADE_EVENT_DISPLAY_ATTRIBUTES = %w(
    name
    id
    source
    event_type
    cost
    hosted_url
    url
    time_zone
    start_date
    start_time
    end_date
    end_time
    industries
    registration_title
    registration_url
  ).freeze

  @@coder = HTMLEntities.new

  def render_attribute(model, attribute_name)
    value = model.attributes[attribute_name]
    return if value.blank?

    content = render_attribute_title attribute_name
    rendered_value = case attribute_name
                     when /url\Z/
                       render_url value
                     when /date\Z/
                       render_date value
                     when 'industries'
                       render_array_value value
                     else
                       decode value
                     end
    content << content_tag(:dd, rendered_value)
  end

  def render_attribute_title(attribute_name)
    content_tag :dt, attribute_name.titleize
  end

  def render_url(str)
    link_to str.sub(%r{\Ahttps?://}i, ''), str
  end

  def render_array_value(array)
    render 'shared/array_value', array: array
  end

  def decode(str)
    @@coder.decode str
  end

  def render_date(date)
    date.strftime('%m/%d/%Y') if date
  end

end
