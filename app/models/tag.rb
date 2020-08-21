class Tag < ApplicationRecord
	has_many :post_tags,dependent: :destroy
	has_many :posts, through: :post_tags,dependent: :destroy

	validates :tag_name, presence: true
	validates :tag_status, presence: true
end
