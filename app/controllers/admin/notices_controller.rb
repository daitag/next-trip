class Admin::NoticesController < ApplicationController
	def index
		@notices = Notice.all
	end

	def show
		@notice = Notice.find(params[:id])
	end

	def new
		@notice = Notice.new
	end

	def create
		@notice = Notice.new(notice_params)
		@notice.save
		redirect_to admin_notice_path(@notice.id)
	end

	def edit
		@notice = Notice.find(params[:id])
	end

	def update
		@notice = Notice.find(params[:id])
		@notice.update(notice_params)
		redirect_to admin_notice_path(@notice.id)
	end

	def destroy
		@notice = Notice.find(params[:id])
		@notice.destroy
		redirect_to admin_notices_path
	end

	private
	def notice_params
		params.require(:notice).permit(:title,:body,:image,:status)
	end
end
