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
		case resource
		when Admin
			new_admin_session_path
		when User
			new_user_session_path
		end
	end

	def set_search
		@search = Post.ransack(params[:q])
		@search_products = @search.result(distinct: true).page params[:page]
	end

	private
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :country])
	end
end
