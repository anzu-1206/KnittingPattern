class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :pattern_id

      t.timestamps
    end
  end
end
