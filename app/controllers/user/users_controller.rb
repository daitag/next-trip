class User::UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit]

	def show
		@user = User.find(params[:id])
		@posts = @user.posts.page(params[:page]).per(10)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
        # パスワードを変更するとログアウトしてしまうので、再ログインが必要
       		sign_in(current_user, bypass: true)
       	 	redirect_to user_path(@user.id)
       	 	flash[:notice] = "ユーザ情報を更新しました"
      	else
			render :edit
			flash.now[:alert] = "ユーザ情報を更新できませんでした"
      	end
	end

	def password
		@user = User.find(params[:id])
	end

	def good
		@good_places =GoodPlace.where(user_id: current_user.id)
	end

	def favorite
		@favorites = Favorite.where(user_id: current_user.id)
	end

	private
	def user_params
		params.require(:user).permit(:name,:email,:country,:image,:password)
	end

	def correct_user
     user = User.find(params[:id])
      if user != current_user
        redirect_to user_path(current_user)
   	 end
  	end
end
