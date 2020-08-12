class User::PostsController < ApplicationController
	def index
		if params[:q].present?
			@search = Post.ransack(search_params)
			@posts = @search.result.page(params[:page])
		else
			params[:q] = { sorts: 'id desc' }
			@search = Post.ransack()
			@posts = Post.page(params[:page])
		end
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
		@comment = Comment.new
	end

	def new
		@post = Post.new
		@post.post_images.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		@post.save!
		redirect_to post_path(@post.id)
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end




	private
	def post_params
		params.require(:post).permit(:title,:country,:prefecture,:location,:body,post_images_images:[],tag_ids:[])
	end

	def search_params
		params.require(:q).permit(:sorts)
	end
end
