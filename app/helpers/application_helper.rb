module ApplicationHelper
  @@coder = HTMLEntities.new

  def decode(str)
    @@coder.decode str
  end
end
