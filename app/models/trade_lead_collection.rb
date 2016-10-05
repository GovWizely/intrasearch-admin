class TradeLeadCollection < ActiveResource::Collection
  extend IntrasearchResourceCollection
  # attr_reader :current_page,
  #             :offset,
  #             :per_page,
  #             :total_entries,
  #             :total_pages
  #
  # def initialize(parsed = {})
  #   @elements = parsed['results']
  #   metadata = parsed['metadata']
  #   @offset = metadata['offset']
  #   @per_page = TradeLead.per_page
  #   @current_page = (@offset / @per_page) + 1
  #   @total_entries = metadata['total']
  #   @total_pages = @total_entries.zero? ? 1 : (@total_entries / @per_page.to_f).ceil
  # end
end
