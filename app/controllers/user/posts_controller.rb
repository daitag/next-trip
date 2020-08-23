class User::PostsController < ApplicationController
	before_action :authenticate_user!
	def index
		# if params[:q].present?
		# 	@search = Post.ransack(search_params)
		# 	@posts = @search.result.page(params[:page])
		# else
		# 	params[:q] = { sorts: 'id desc' }
		# 	@search = Post.ransack()
		# 	@posts = Post.page(params[:page])
		# end
		# 公開設定がtrueのみ表示
		if params[:tag_id]
			@tag = Tag.find(params[:tag_id])
			@posts = @tag.posts
			# @posts = @search.result(distinct: true).where(tag_id: params[:tag_id])
		else
			@search_products = @search.result(distinct: true).where(post_status: true).order('id desc').page(params[:page]).per(16)
		end
		@tags = Tag.where(tag_status: true)
		@post_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(4).pluck(:post_id))
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
		if @post.save
			redirect_to post_path(@post.id)
			flash[:notice] = "投稿できました"
		else
			flash.now[:alert] = "投稿できませんでした"
			render :new
		end
	end

	def destroy
		@post = Post.find(params[:id])
		if @post.destroy
			redirect_to posts_path
			flash[:notice] = "削除ができました"
		else
			flash.now[:alert] = "削除ができませんでした"
			render :show
		end
	end




	private
	def post_params
		params.require(:post).permit(:title,:country,:prefecture,:city,:location,:body,post_images_images:[],tag_ids:[])
	end

	def search_params
		params.require(:q).permit(:sorts)
	end

end
