class CreateNumberPlanEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :number_plan_entries do |t|
      t.string :prefix
      t.integer :max_length
      t.integer :min_length
      t.text :usage
      t.text :comment

      t.timestamps
    end
  end
end
