class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user

    def current_user
        return nil if !session[:session_token]
        User.find_by(session_token: session[:session_token])
    end

    def log_user_in!(user)
        session[:session_token] = user.reset_session_token!
    end
end
