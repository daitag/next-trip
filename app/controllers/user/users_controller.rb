class User::UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:show,:edit]

	def show
		@user = User.find(params[:id])
		@posts = @user.posts.all
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
       	 	flash[:notice] = "パスワードを更新しました"
      	else
			redirect_to user_path(@user.id)
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
