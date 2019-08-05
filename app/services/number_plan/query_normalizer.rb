module NumberPlan
  class QueryNormalizer
    attr_reader :search_query

    def initialize(search_query)
      @search_query = search_query
    end

    def call
      @search_query.gsub!(/49\s?(\d+)/, '\1')
      @search_query.gsub!(/(\d+)\-/, '\1')
      @search_query.gsub!(/49\s?\(?0\)?\s? (\d+)/, '\1')
      @search_query
    end
  end
end
