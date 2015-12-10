class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def index
        require_login
        @users = User.all.shuffle
    end

    def create
        @user = User.new(request_params)

        respond_to do |format|
            if @user.save
                session[:user_id] = @user.id

                flash[:success] = 'New user created successfully!'
                format.html {redirect_to users_path}
            else
                flash[:error] = 'Cannot create new user!'
                format.html { render :action => :new}
            end
        end
    end

    private
        def request_params
            params.require(:user).permit(:email, :name, :password, :password_confirm)
        end
end
