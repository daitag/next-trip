class Post < ApplicationRecord
	belongs_to :user
	attachment :image
	has_many :favorites
	has_many :comments

	validates :title, presence: true
	validates :body, presence: true
end
