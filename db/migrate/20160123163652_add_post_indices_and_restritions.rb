class AddPostIndicesAndRestritions < ActiveRecord::Migration
  def change
    add_index :posts, [:user_id, :id], unique: true
    add_index :posts, :created_at
  end
end
