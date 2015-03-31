require 'pry'
class UsersController < ApplicationController
  def new
  	@user= User.new  
  end

  def create
    @user=User.new(user_params)
    @user.save
    if @user.save
       userRegister = BiometricFaceAuthentication.new
	     response = userRegister.register(@user.username)
	     if response != nil && response["trained"] == true
	  	    session[:user_id]=@user.id
	        redirect_to user_path(@user.id),notice: "New user created."
	     else
             render 'new'
        end
    end

  end 


  def index
  end


  def show
  	@user=User.find(params[:id])
    @bot = Bot.new(name: "minkbot", data_file: "bot_data")
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    @oldUserName = @user.username
    @user = User.update(@user.id, user_params)
    if @user.save
      @newUserName = @user.username
    end
    userUpdate = BiometricFaceAuthentication.new
    response = userUpdate.edit(@oldUserName , @newUserName)
    if response != nil && response["trained"] == true
          session[:user_id]=@user.id
          redirect_to user_path(@user.id),notice: "User Account updated."
       else
        
        redirect_to  user_path , method: :put
      end
  end

  def destroy
    @user = User.find params[:id]
    userDelete = BiometricFaceAuthentication.new
    response = userDelete.request_delete(@user.username)
    @user.destroy
    redirect_to  root_path 
  end

  def delete
  end


  private

  def user_params
  	params.require(:user).permit(:username, :email)
  end
end
