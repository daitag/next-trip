class User::PostsController < ApplicationController
	def index
		if params[:q].present?
			@search = Post.ransack(search_params)
			@posts = @search.result
		else
			params[:q] = { sorts: 'id desc' }
			@search = Post.ransack()
			@posts = Post.all
		end
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
		@comment = Comment.new
	end

	def new
		@post = Post.new
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

	def search
		if params[:q].present?
			@search = Post.ransack(search_params)
			@posts = @search.result
		else
			params[:q] = { sorts: 'id desc' }
			@search = Post.ransack()
			@posts = Post.all
		end
	end


	private
	def post_params
		params.require(:post).permit(:title,:location,:body,:image)
	end

	def search_params
		params.require(:q).permit(:sorts)
	end
end
