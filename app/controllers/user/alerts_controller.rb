class User::AlertsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		alert = current_user.alerts.new(post_id: @post.id)
		alert.save
		redirect_to request.referer
		flash[:notice] = "管理者に報告しました"
	end

	def destroy
		@post = Post.find(params[:post_id])
		alert = current_user.alerts.find_by(post_id: @post.id)
		alert.destroy
		redirect_to request.referer
		flash[:notice] = "管理者への報告を取り下げました"
	end
end
