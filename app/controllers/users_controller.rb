class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def index
    require_login
    @users = User.all
  end

  def create
    @user = User.new(request_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id

        flash[:success] = 'New user created successfully!'
        format.html { redirect_to users_path }
      else
        flash[:error] = 'Cannot create new user!'
        format.html { render :action => :new }
      end
    end
  end

  def manage_friends
    current_user

    ## Handle adding friend
    if params[:add_friend]
      @new_friendship = @current_user.add_friendship(params[:add_friend])
      unless @new_friendship.nil?
        flash[:success] = 'The user has been added as friend successfully!'
      else
        flash[:error] = 'Cannot add this user as friend!'
      end
    end

    ## Handle removing friend out of friend list
    if params[:remove_friend]
      @current_user.remove_friendship(params[:remove_friend])
      #flash[:success] = 'The user has been removed as friend successfully!'
    end

    ## Handle set block friend
    if params[:set_block]
      @current_user.set_block_friend(params[:friend_id], params[:set_block])
    end

    ## Reload the 2 lists
    @friends_of_current_user = @current_user.friends
    @users_not_in_friend_list = @current_user.users_not_in_friend_list

  end

  private
  def request_params
    params.require(:user).permit(:email, :name, :password, :password_confirm)
  end
end
