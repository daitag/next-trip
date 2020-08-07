class Admin::HomesController < ApplicationController
	def top
		@users = User.all
		@alerts = Alert.all
	end
end
