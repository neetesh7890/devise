class ActionsController < ApplicationController
		
	#Actions
	def show
	end

	def edit
		if params[:id].present?
			@user = User.find(params[:id])	
		else
			render 'new'
		end
	end

	def update
		@user = User.find(params[:id])
		@user.password = params[:user][:password]
		if @user.update(params.require(:user).permit(:password))
			redirect_to forgot_password_path(@user)	
		else
			flash[:notice] = "Profile Could not updated"
		end
	
	end
end
