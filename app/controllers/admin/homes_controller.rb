class Admin::HomesController < ApplicationController
	def top
		@users = User.all
		@alerts = Alert.page(params[:page]).per(10).reverse_order
	end
end
