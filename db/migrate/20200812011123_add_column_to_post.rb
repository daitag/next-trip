class AddColumnToPost < ActiveRecord::Migration[5.2]

  def change
  	add_column :posts, :country, :string
  	add_column :posts, :prefecture, :string
  end
end