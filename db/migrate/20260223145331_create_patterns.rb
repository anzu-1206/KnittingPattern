class CreatePatterns < ActiveRecord::Migration[7.2]
  def change
    create_table :patterns do |t|
      t.string :name
      t.string :introduction
      t.string :item
      t.string :yarn
      t.string :crochet
      t.string :knitting
      t.string :hook
      t.boolean :is_public
      t.integer :category
      t.integer :difficulty

      t.timestamps
    end
  end
end
