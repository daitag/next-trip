class User::GoodPlacesController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		good_place = current_user.good_places.new(post_id: @post.id)
		good_place.save
		redirect_to request.referer
	end

	def destroy
		@post = Post.find(params[:post_id])
		good_place = current_user.good_places.find_by(post_id: @post.id)
		good_place.destroy
		redirect_to request.referer
	end
end
