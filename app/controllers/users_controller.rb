class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def index
        @users = User.all.shuffle
    end

    def create
        @user = User.new(request_params)

        respond_to do |format|
            if @user.save
                session[:user_id] = @user.id

                format.html {redirect_to users_path, alert: 'Created user!'}
            else
                format.html { render :action => :new}
            end
        end
    end

    private
        def request_params
            params.require(:user).permit(:email, :name, :password, :password_confirm)
        end
end
