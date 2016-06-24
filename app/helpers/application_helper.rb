module ApplicationHelper
  @@coder = HTMLEntities.new

  def render_attribute(model, attribute_name)
    value = model.attributes[attribute_name]
    return if value.blank?

    case attribute_name
    when /url\Z/
      render_url value
    when /date\Z/
      render_date value
    else
      decode value
    end
  end

  def render_url(str)
    link_to str.sub(%r{\Ahttps?://}i, ''), str
  end

  def decode(str)
    @@coder.decode str
  end

  def render_date(date)
    date.strftime('%m/%d/%Y') if date
  end

end
