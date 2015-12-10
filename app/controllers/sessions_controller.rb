class SessionsController < ApplicationController
  def new
  end

  def create

        @user = User.find_by_email(params[:user][:email])

        if @user && @user.authenticate(params[:user][:password])
          	session[:user_id] = @user.id
          	
          	flash[:success] = 'Logged in successfully!'

        	redirect_to users_path
        else
        	flash[:success] = 'Fail to logged in!'

        	render :new
        end
  end

  def destroy
    session[:user_id] = nil
    redirect_to welcome_index_path
  end

end
