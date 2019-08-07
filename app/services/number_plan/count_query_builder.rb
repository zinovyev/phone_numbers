module NumberPlan
  class CountQueryBuilder < BaseQueryBuilder
    private

    def build_query
      <<-SQL
        SELECT COUNT("#{table_name}".*) AS total_count
        FROM "#{table_name}", to_tsquery(?) query
        WHERE textsearchable_index_col @@ query
      SQL
    end

    def default_options
      {}
    end
  end
end
