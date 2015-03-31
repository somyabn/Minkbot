class SessionsController < ApplicationController
	def create
		
			@user=User.find_by(username: params[:username])
			
			if @user 
				userAuthorise = BiometricFaceAuthentication.new
	            response = userAuthorise.authorise(@user.username)
	            if response != nil && response["confirmed"] == true
				flash[:notice]="Successfully signed in!"
				session[:user_id]=@user.id
				redirect_to user_path(@user.id)
			 else
			    flash[:alert]="User does not exist. Please sign up."
			    redirect_to users_path
		    end
		end
	end

	 
	def destroy
		session[:user_id]=nil
		flash[:notice]="Logged out..."
		redirect_to root_path
	end
end
