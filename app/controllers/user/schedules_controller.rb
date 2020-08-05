class User::SchedulesController < ApplicationController
	require "date"

	def index
		@schedule = Schedule.new
		@schedules = Schedule.all
		@today = Date.current
	end

	def create
		@schedule = Schedule.new(schedule_params)
		@schedule.user_id = current_user.id
		@schedule.save!
		redirect_to request.referer
	end

	def destroy
		@schedule = Schedule.find(params[:id])
		@schedule.destroy!
		redirect_to request.referer
	end

	private
	def schedule_params
		params.require(:schedule).permit(:content, :day)
	end
end