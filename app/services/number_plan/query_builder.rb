module NumberPlan
  class QueryBuilder < BaseQueryBuilder
    private

    def build_query
      <<-SQL
        SELECT "#{table_name}".*, ts_rank(textsearchable_index_col, query) AS rank
        FROM "#{table_name}", to_tsquery(?) query
        WHERE textsearchable_index_col @@ query
        ORDER BY rank DESC
        LIMIT #{limit} OFFSET #{offset}
      SQL
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

    def default_options
      {
        page: 1,
        per_page: 10,
      }
    end
  end
end
