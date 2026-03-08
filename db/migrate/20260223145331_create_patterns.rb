class CreatePatterns < ActiveRecord::Migration[7.2]
  def change
    create_table :patterns do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :introduction

      t.text :pattern_data, null: false
      t.integer :grid_width, default: 20
      t.integer :grid_height, default: 20

      t.boolean :is_public
      t.integer :category

      t.timestamps
    end
  end
end
