module OrmAdapter
  class ActiveResource < Base
    # Return list of column/property names
    def column_names
      klass.known_attributes
    end

    # @see OrmAdapter::Base#get!
    def get!(id)
      klass.find(wrap_key(id))
    end

    # @see OrmAdapter::Base#get
    def get(id)
      klass.find(wrap_key(id))
    end

    # @see OrmAdapter::Base#find_first
    def find_first(options = {})
      construct_relation(klass, options).first
    end

    # @see OrmAdapter::Base#find_all
    def find_all(options = {})
      construct_relation(klass, options)
    end

    # @see OrmAdapter::Base#create!
    # def create!(attributes = {})
    #   klass.create!(attributes)
    # end

    # @see OrmAdapter::Base#destroy
    # def destroy(object)
    #   object.destroy && true if valid_object?(object)
    # end

    protected
    def construct_relation(relation, options)
      conditions, order, limit, offset = extract_conditions!(options)

      relation = relation.where(conditions)
      relation = relation.order(order_clause(order)) if order.any?
      relation = relation.limit(limit) if limit
      relation = relation.offset(offset) if offset

      relation
    end

    def order_clause(order)
      order.map {|pair| "#{pair[0]} #{pair[1]}"}.join(",")
    end
  end
end

ActiveSupport.on_load(:active_resource) do
  extend ::OrmAdapter::ToAdapter
  self::OrmAdapter = ::OrmAdapter::ActiveResource
end
