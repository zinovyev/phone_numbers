module NumberPlan
  class BaseQueryBuilder
    attr_reader :search_query, :relation

    def initialize(relation, search_query, options)
      @relation = relation
      @search_query = search_query
      @options = options
    end

    def call
      [build_query, search_query_terms]
    end

    private

    def build_numeric_query(query_part)
      query_part.split(//).each_with_object([]).with_index do |(part, acc), idx|
        if acc[idx - 1]
          acc <<  (acc[idx - 1] + part)
        else
          acc <<  part
        end
      end
    end

    def search_query_terms
      subqueries.each_with_object([]) do |subquery, terms|
        terms.concat(process_subquery(subquery))
      end.join(' | ')
    end

    def process_subquery(subquery)
      if numeric?(subquery)
        build_numeric_query(subquery).map { |term| "#{term}:A" }
      else
        ["#{subquery }:*B"]
      end
    end

    def table_name
      @table_name = relation.table_name
    end

    def numeric?(subquery)
      subquery.match?(/^\d+$/)
    end

    def subqueries
      search_query.gsub(/"|'/, '')&.split(/\s/) || []
    end

    def offset
      offset = (page_num - 1) * limit
      offset >= 0 ? offset : 0
    end

    def limit
      @limit ||= @options[:per_page].to_i
    end

    def page_num
      @page_num ||= @options[:page].to_i
    end
  end
end
