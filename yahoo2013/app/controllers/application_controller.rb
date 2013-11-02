class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private
    def current_user
      if sign_in?
        User.find(session[:id])
      else
        nil
      end
    rescue
      nil
    end

    def fb_sign_in(user)
      session[:fb_login] = true if user
      sign_in(user)
    end

    def y_sign_in(user)
      session[:y_login] = true if user
      sign_in(user)
    end

    def sign_in(user)
      session[:id] = user.id if user
    end

    def sign_in?
      if session[:id]
        true
      else
        false
      end
    end

    def fb_sign_in?
      session[:fb_login]
    end
    def y_sign_in?
      session[:y_login]
    end
end
