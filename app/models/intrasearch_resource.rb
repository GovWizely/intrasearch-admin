module IntrasearchResource
  def self.extended(base)
    base.extend ModuleMethods
    base.include InstanceMethods

    base.site = URI.join(Intrasearch.configuration.host_url, '/admin/').to_s
    base.collection_parser = "#{base.name}Collection".constantize

    base.class_eval do
      before_update :generate_html_description
    end

  end

  module ModuleMethods
    def per_page
      collection_parser.per_page
    end

    def all(*args)
      args ||= []
      options = args.first || {}
      page_str = options.delete(:page)
      page = [page_str.to_i, 1].max
      options[:params] = {
        limit: per_page,
        offset: page_to_offset(page)
      }
      super
    end

    def page_to_offset(page)
      (page * per_page) - per_page
    end
  end

  module InstanceMethods
    protected

    def update
      run_callbacks :update do
        connection.patch(element_path(prefix_options), encode, self.class.headers).tap do |response|
          load_attributes_from_response(response)
        end
      end
    end

    def generate_html_description
      filter = HTML::Pipeline::MarkdownFilter.new md_description
      self.html_description = filter.call
      true
    end
  end
end
