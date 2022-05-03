class UsersController < ApplicationController
    def new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            self.log_user_in!(@user)
            render :show
        else
            flash.now[:errors] = @user.errors.full_messages[0]
            render :new
        end
    end

    def show
      if current_user
        redirect_to bands_url
      else
        redirect_to new_session_url
      end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end
