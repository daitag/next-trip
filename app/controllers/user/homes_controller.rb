class User::HomesController < ApplicationController
	def top
		@notices = Notice.where(status: true)
	end

	def notice
		@notice = Notice.find(params[:id])
	end
end
