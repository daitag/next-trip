class Admin::NoticesController < ApplicationController
	before_action :authenticate_admin!
	def index
		@notices = Notice.page(params[:page])
	end

	def show
		@notice = Notice.find(params[:id])
	end

	def new
		@notice = Notice.new
	end

	def create
		@notice = Notice.new(notice_params)
		if @notice.save
			redirect_to admin_notice_path(@notice.id)
			flash[:notice] = "お知らせを作成しました"
		else
			flash.now[:alert] = "お知らせの作成に失敗しました"
			render :new
		end
	end

	def edit
		@notice = Notice.find(params[:id])
	end

	def update
		@notice = Notice.find(params[:id])
		if @notice.update(notice_params)
			redirect_to admin_notice_path(@notice.id)
			flash[:notice] = "お知らせ情報を更新しました"
		else
			flash.now[:alert] = "お知らせの更新に失敗しました"
			render :edit
		end
	end

	def destroy
		@notice = Notice.find(params[:id])
		if @notice.destroy
			redirect_to admin_notices_path
			flash[:notice] = "お知らせを削除しました"
		else
			flash.now[:alert] = "お知らせの削除に失敗しました"
			render :show
		end
	end

	private
	def notice_params
		params.require(:notice).permit(:title,:body,:image,:status,:notice_tag)
	end
end
