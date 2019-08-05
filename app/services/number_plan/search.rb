module NumberPlan
  class Search
    attr_reader :search_query, :relation

    def initialize(relation, search_query)
      @relation = relation
      @search_query = search_query
    end

    def call
      @search_query = query_normalizer.call
      relation.find_by_sql(query_builder.call)
    end

    private

    def query_normalizer
      QueryNormalizer.new(@search_query)
    end

    def query_builder
      QueryBuilder.new(@relation, @search_query)
    end
  end
end
