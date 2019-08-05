module NumberPlan
  class QueryBuilder
    attr_reader :search_query, :relation

    def initialize(relation, search_query)
      @relation = relation
      @search_query = search_query
    end

    def call
      [build_query, search_query_terms]
    end

    private

    def build_query
      <<-SQL
        SELECT "#{table_name}".*, ts_rank(textsearchable_index_col, query) AS rank
        FROM "#{table_name}", to_tsquery(?) query
        WHERE textsearchable_index_col @@ query
        ORDER BY rank DESC;
      SQL
    end

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
  end
end
