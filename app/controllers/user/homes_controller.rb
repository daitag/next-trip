class User::HomesController < ApplicationController
	def top
		@notices = Notice.where(status: true).limit(10).reverse_order
		@posts = Post.all
		@ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(4).pluck(:post_id))
	end

	def notice
		@notice = Notice.find(params[:id])
	end
end
