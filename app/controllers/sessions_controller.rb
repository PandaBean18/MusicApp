class SessionsController < ApplicationController
  def new
    if !current_user
        render :new
    else   
        redirect_to user_url(current_user)
    end
  end

  def create
    email = session_params[:email]
    password = session_params[:password]
    user = User.find_by_credentials(email, password)
    if user 
        self.log_user_in!(user)
        redirect_to user_url(current_user)
    else 
        flash.now[:errors] = 'Invalid Email or Password'
        render :new 
    end

  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
