class User::HomesController < ApplicationController
	def top
		@notices = Notice.where(status: true).page(params[:page])
	end

	def notice
		@notice = Notice.find(params[:id])
	end
end
