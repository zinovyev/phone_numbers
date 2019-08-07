module NumberPlan
  class Search
    attr_reader :search_query, :relation

    def initialize(relation, search_query, options = {})
      @relation = relation
      @search_query = search_query
      @options = default_options.merge(options)
    end

    def call
      @search_query = query_normalizer.call
      data = relation.find_by_sql(query_builder.call)
      total_count = relation.find_by_sql(count_query_builder.call).first.total_count
      SearchResult.new(data, count_pages(total_count))
    end

    private

    def count_pages(total_count)
      (total_count.to_i / @options[:per_page].to_f).ceil
    end

    def query_normalizer
      QueryNormalizer.new(@search_query)
    end

    def count_query_builder
      CountQueryBuilder.new(@relation, @search_query, @options)
    end

    def query_builder
      QueryBuilder.new(@relation, @search_query, @options)
    end

    def default_options
      {
        page: 1,
        per_page: 10,
      }
    end
  end
end
