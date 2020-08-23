class Admin::PostsController < ApplicationController
	before_action :authenticate_admin!
	def show
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to admin_post_path(@post)
			flash[:notice] = "投稿情報を更新しました"
		else
			flash.now[:alert] = "投稿情報の更新に失敗しました"
			render :show
		end
	end

	private
	def post_params
		params.require(:post).permit(:post_status)
	end
end
