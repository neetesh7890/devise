class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  def edit
  end

  def update
    @detail = current_user.user_detail.present? ? current_user.user_detail : current_user.build_user_detail
    params[:user][:avatar].present? ? current_user.size = params[:user][:avatar].size : current_user.size = 0
    current_user.avatar = params[:user][:avatar]
    
    if current_user.save && @detail.update(params.require(:user_detail).permit(:address, :city, :pincode, :phone))
      flash[:notice] = "#{current_user.firstname} Your Profile successfully updated"
      redirect_to dashboards_path
    else
      render 'edit'
    end
  end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   current_user.avatar = params[:user][:avatar]
  #   if current_user.update(user_params)
  #     redirect_to dashboards_path
  #   else
  #     render 'edit'
  #   end
  #   # after_update_path_for(resource)
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # def after_update_path_for(resource)
  #   case resource
  #   when :user, User
  #     resource.avatar? ? redirect_to dashboards_path : redirect_to root_path
  #   else
  #     super
  #   end
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
