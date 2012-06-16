class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.integer :votes, :null => false, :default => 0

      t.timestamps
    end
  end
end
