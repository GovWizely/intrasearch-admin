class TradeEvent < ActiveResource::Base
  @per_page = 30

  class << self
    attr_reader :per_page
  end

  self.site = URI.join(Intrasearch.configuration.host_url, '/admin/').to_s
  self.collection_parser = TradeEventCollection

  def self.all(*args)
    options = args.first
    page_str = options.delete(:page)
    page = [page_str.to_i, 1].max
    options[:params] = {
      limit: per_page,
      offset: page_to_offset(page)
    }
    super
  end

  def self.page_to_offset(page)
    (page * per_page) - per_page
  end
end
