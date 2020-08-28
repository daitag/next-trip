class Notice < ApplicationRecord
	attachment :image

	validates :title, presence: true,length: { maximum: 15 }
	validates :body, presence: true,length: { maximum: 150 }
	validates :image, presence: true
end
