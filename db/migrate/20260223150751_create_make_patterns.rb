class CreateMakePatterns < ActiveRecord::Migration[7.2]
  def change
    create_table :make_patterns do |t|
      t.string :start_type
      t.integer :grid_width
      t.integer :grid_height
      t.text :pattern_data

      t.timestamps
    end
  end
end
