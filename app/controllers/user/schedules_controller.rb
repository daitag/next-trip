class User::SchedulesController < ApplicationController
	require "date"

	def index
		@schedule = Schedule.new
		@schedules = Schedule.where(user_id: current_user)
		@today = Date.current
	end

	def create
		@schedule = Schedule.new(schedule_params)
		@schedule.user_id = current_user.id
		if @schedule.save
			redirect_to request.referer
			flash[:notice] = "スケジュールを計画しました"
		else
			flash.now[:alert] = "スケジュールの投稿に失敗しました"
			render :index
		end

	end

	def destroy
		@schedule = Schedule.find(params[:id])
		if @schedule.destroy
			redirect_to request.referer
			flash[:notice] = "スケジュールを削除しました"
		else
			flash.now[:alert] = "スケジュールの削除に失敗しました"
			render :index
		end
	end

	private
	def schedule_params
		params.require(:schedule).permit(:content, :start_day, :end_day)
	end
end
