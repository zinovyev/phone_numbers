module Search
  class NumberPlanSearch
    attr_reader :full_query, :relation

    def initialize(relation, full_query, options = {})
      @relation = relation
      @full_query = full_query
      @options = default_options.merge(options)
    end

    def call
      relation.find_by_sql([build_query, "#{search_query_terms}"])
    end

    private

    def build_query
      <<-SQL
        SELECT "#{table_name}".*, ts_rank(textsearchable_index_col, query) AS rank
        FROM "#{table_name}", to_tsquery(?) query
        WHERE textsearchable_index_col @@ query
        ORDER BY rank DESC
        LIMIT #{per_page} OFFSET #{offset}
      SQL
    end

    def table_name
      @table_name = relation.table_name
    end

    def search_query_terms(terms = [])
      subqueries.each do |subquery|
        if numeric?(subquery)
          terms += build_numeric_query(subquery).map { |term| "#{term}:A" }
        else
          terms << "#{subquery }:*B"
        end
      end
      terms.join(' | ')
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

    def numeric?(subquery)
      subquery.match?(/^\d+$/)
    end

    def subqueries
      full_query.gsub(/"|'/, '')&.split(/\s/) || []
    end

    def offset
      offset = @options[:page].to_i * @options[:per_page].to_i
      offset >= 0 ? offset : 0
    end

    def default_options
      {
        page: 1,
        per_page: 10,
      }
    end
  end
end
