class Admin::TagsController < ApplicationController
	before_action :authenticate_admin!
	def index
		@tag = Tag.new
		@tags = Tag.all
	end

	def create
		@tag = Tag.new(tag_params)
		@tags = Tag.all
		if @tag.save
			redirect_to admin_tags_path
			flash[:notice] = "タグを作成できました"
		else
			flash.now[:alert] = "タグの作成に失敗しました"
			render :index
		end
	end

	def edit
		@tag = Tag.find(params[:id])
	end

	def update
		@tag = Tag.find(params[:id])
		if @tag.update(tag_params)
			redirect_to admin_tags_path
			flash[:notice] = "タグ情報を更新できました"
		else
			flash.now[:alert] = "タグ情報ができませんでした"
			render :edit
		end
	end

	private
	def tag_params
		params.require(:tag).permit(:tag_name,:tag_status)
	end
end
