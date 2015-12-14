class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:success] = 'Logged in successfully!'
      redirect_to messages_path
    else
      flash[:error] = 'Fail to logged in!'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to welcome_index_path
  end

end
