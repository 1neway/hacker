class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text    :title
      t.string  :url
      t.integer :user_id
      t.integer :ask?, :default => 0
      t.timestamps
    end
  end
end
