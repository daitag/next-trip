class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
    	t.string :title
    	t.text :body
    	t.string :image_id
    	t.boolean :status

      t.timestamps
    end
  end
end
