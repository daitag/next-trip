class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
    	t.integer :user_id
    	t.date :start_day
    	t.date :end_day
    	t.text :content

      t.timestamps
    end
  end
end
