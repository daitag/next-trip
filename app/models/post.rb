class Post < ApplicationRecord
	belongs_to :user
	attachment :image

	validates :title, presence: true
	validates :body, presence: true
	has_many :favorites, dependent: :destroy

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
