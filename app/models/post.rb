class Post < ApplicationRecord
	belongs_to :user
	has_many :post_images, dependent: :destroy
	accepts_attachments_for :post_images, attachment: :image
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

	ransacker :favorites_count do
    	query = '(SELECT COUNT(favorites.post_id) FROM favorites where favorites.post_id = posts.id GROUP BY favorites.post_id)'
    	Arel.sql(query)
  	end

  	ransacker :good_places_count do
    	query = '(SELECT COUNT(good_places.post_id) FROM good_places where good_places.post_id = posts.id GROUP BY good_places.post_id)'
    	Arel.sql(query)
  	end
end
