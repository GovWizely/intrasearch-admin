class TradeEvent < ActiveResource::Base
  extend IntrasearchResource
end
# class TradeEvent < ActiveResource::Base
#   @per_page = 30
#
#   class << self
#     attr_reader :per_page
#   end
#
#   self.site = URI.join(Intrasearch.configuration.host_url, '/admin/').to_s
#   self.collection_parser = TradeEventCollection
#
#   before_update :generate_html_description
#
#   def self.all(*args)
#     args ||= []
#     options = args.first || {}
#     page_str = options.delete(:page)
#     page = [page_str.to_i, 1].max
#     options[:params] = {
#       limit: per_page,
#       offset: page_to_offset(page)
#     }
#     super
#   end
#
#   def self.page_to_offset(page)
#     (page * per_page) - per_page
#   end
#
#   protected
#
#   def update
#     run_callbacks :update do
#       connection.patch(element_path(prefix_options), encode, self.class.headers).tap do |response|
#         load_attributes_from_response(response)
#       end
#     end
#   end
#
#   def generate_html_description
#     filter = HTML::Pipeline::MarkdownFilter.new md_description
#     self.html_description = filter.call
#     true
#   end
# end
