class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_search

	def after_sign_in_path_for(resource)
		case resource
		when Admin
			admin_top_path
		when User
			posts_path
		end
	end

	def after_sign_up_path_for(resource)
		case resource
		when Admin
			admin_top_path
		when User
			posts_path
		end
	end

	def after_sign_out_path_for(resource)
		if resource == :admins
			new_admin_session_path
		else
			root_path
		end
	end

	def set_search
		@search = Post.ransack(params[:q])
	end

	private
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :country])
	end
end
