class Notice < ApplicationRecord
	attachment :image

	validates :title, presence: true
	validates :body, presence: true
	validates :image, presence: true
	validates :notice_tag, presence: true
end
