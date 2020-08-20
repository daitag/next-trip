class User::UsersController < ApplicationController


	def show
		@user = User.find(params[:id])
		@posts = @user.posts.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if current_user.update(user_params)
        # パスワードを変更するとログアウトしてしまうので、再ログインが必要
       		sign_in(current_user, bypass: true)
       	 	redirect_to user_path(@user.id)
      	else
        	@user.update(user_params)
			redirect_to user_path(@user.id)
      	end
	end

	def password
		@user = User.find(params[:id])
	end

	def good
		@good_places =GoodPlace.where(user_id: current_user.id)
	end

	private
	def user_params
		params.require(:user).permit(:name,:email,:country,:image,:password)
	end
end
