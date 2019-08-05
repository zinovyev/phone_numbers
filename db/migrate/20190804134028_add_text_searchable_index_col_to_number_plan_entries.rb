class AddTextSearchableIndexColToNumberPlanEntries < ActiveRecord::Migration[5.2]
  def up
    ActiveRecord::Base.transaction do
      add_column :number_plan_entries, :textsearchable_index_col, :tsvector
      add_index :number_plan_entries, :textsearchable_index_col, using: :gin
    end
  end

  def down
    remove_index :number_plan_entries, :textsearchable_index_col, using: :gin
    remove_column :number_plan_entries, :textsearchable_index_col
  end
end
