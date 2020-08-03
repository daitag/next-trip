class Schedule < ApplicationRecord
	belongs_to :user

	validates :content, presence: true
	validates :day, presence: true
end
