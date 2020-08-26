class Schedule < ApplicationRecord
	belongs_to :user

	validates :content, presence: true,length: { maximum: 15 }
	validates :start_day, presence: true
	validates :end_day, presence: true
end
