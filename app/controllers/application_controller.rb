class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    dashboards_path
  end

  protected

    def configure_permitted_parameters
      
      # if params[:action] == 'create'
      #   devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      #     user_params.permit(:firstname,:lastname)
      #   end
      # end

      
    end

    # def configure_permitted_parameters
    #   debugger
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    # end
end
