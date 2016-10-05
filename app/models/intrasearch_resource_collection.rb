module IntrasearchResourceCollection
  def self.extended(base)
    class << base
      attr_reader :per_page,
                  :resource_class
    end

    base.class_eval do
      @per_page = 30
      @resource_class = base.name.sub(/Collection\Z/, '').constantize

      attr_reader :current_page,
                  :offset,
                  :per_page,
                  :total_entries,
                  :total_pages
    end

    base.include InstanceMethods
  end

  module InstanceMethods
    def initialize(parsed = {})
      @elements = parsed['results']
      metadata = parsed['metadata']
      @offset = metadata['offset']
      @per_page = self.class.resource_class.per_page
      @current_page = (@offset / @per_page) + 1
      @total_entries = metadata['total']
      @total_pages = @total_entries.zero? ? 1 : (@total_entries / @per_page.to_f).ceil
    end
  end
end