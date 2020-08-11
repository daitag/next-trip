class Admin::PostsController < ApplicationController
	def show
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		@post.update(post_params)
		redirect_to admin_post_path(@post)
	end

	private
	def post_params
		params.require(:post).permit(:post_status)
	end
end