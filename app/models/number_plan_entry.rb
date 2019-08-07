# == Schema Information
#
# Table name: number_plan_entries
#
#  id                       :bigint           not null, primary key
#  prefix                   :string
#  max_length               :integer
#  min_length               :integer
#  usage                    :text
#  comment                  :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  textsearchable_index_col :tsvector
#

class NumberPlanEntry < ApplicationRecord
  class << self
    def search(query, options = {})
      NumberPlan::Search.new(NumberPlanEntry, query, options).call
    end
  end

  after_save :update_textsearchable_index_col

  def update_textsearchable_index_col
    self.class.connection.execute(update_textsearchable_index_col_query)
  end

  def update_textsearchable_index_col_query
    <<-SQL
      UPDATE #{self.class.table_name}
      SET textsearchable_index_col = setweight(to_tsvector('german', coalesce(prefix,'')), 'A') ||
                                     setweight(to_tsvector('german', coalesce(comment,'')), 'B')
      WHERE id = #{id};
    SQL
  end
end
