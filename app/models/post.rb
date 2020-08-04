class Post < ApplicationRecord
	belongs_to :user
	attachment :image
	has_many :favorites, dependent: :destroy
	has_many :good_places, dependent: :destroy
	has_many :comments, dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def good_placed_by?(user)
		good_places.where(user_id: user.id).exists?
	end
end
