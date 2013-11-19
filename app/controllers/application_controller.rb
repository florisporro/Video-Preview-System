class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def check_login
    if session[:current_user_id] == nil
      puts "User is not logged in. Redirecting to login page."
      puts "User ID in session is: " + session[:current_user_id].to_s
      puts "@_current_user is: " + @_current_user.inspect
      flash[:alert] = "Please login to access this page."
      redirect_to action: 'login'
    else
      puts "User has an ID set in session. Matching ID to database."
      @_current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end
  end

  def check_admin_rights
	if !@_current_user.admin
	  redirect_to login_url
	end
  end
end
