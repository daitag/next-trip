class Comment < ApplicationRecord
	belongs_to :user
	belogns_to :post

	validate :comment, dependent: :destroy
end
