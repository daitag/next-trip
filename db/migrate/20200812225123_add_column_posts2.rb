class AddColumnPosts2 < ActiveRecord::Migration[5.2]
  def change
  	add_column :posts, :prefecture, :string
  	add_column :posts, :country, :string
  end
end
