class Admin::UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to admin_user_path(@user.id)
			flash[:notice] = "ユーザ情報を更新しました"
		else
			flash.now[:alert] = "ユーザ情報の更新ができませんでした"
			render :edit
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :country, :email, :user_status)
	end
end
