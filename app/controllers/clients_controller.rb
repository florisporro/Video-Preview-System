class ClientsController < ApplicationController
  before_filter :check_login, :except => [:login, :logout]

  def login
    if session[:current_user_id].nil? and params[:password].nil?
      puts "Nothing done yet. Rendering login form."
      render    
    else
      if !session[:current_user_id].nil?
        # User may already be logged in, let's check
        u = User.find(session[:current_user_id])
      else
        # Assume user has entered password
        puts "Finding user by password: " + params[:password].to_s
        u = User.find_by(password: params[:password])
      end
      
      if !u.nil?
        puts "User found: " + u.name

        # Set the session to remember user
        session[:current_user_id] = u.id
        puts "Set session :current_user_id to: " + session[:current_user_id].to_s

        # Make reference variable for use in the viewer
        @_current_user ||= session[:current_user_id] && u

        puts "@_current_user created:" + @_current_user.inspect

        # Set last login timestamp and save to database
        u.touch

        if @_current_user.admin
          puts "User is admin. Redirect to admin panel."
          redirect_to admin_url
        else
          redirect_to action: "index"
        end
      else
        puts "Failed to find user using supplied password. Triggering error and rendering."
        flash[:notice] = "User with password " + params[:password].to_s + " not found. (log in was not correct)"
        render
      end
    end
  end

  def logout
    reset_session
    flash[:notice] = "Thanks for logging out!"
    redirect_to action: "login"
  end

  def index
    @videos = @_current_user.videos

    @videos.each do |video|
      video.videolink = video.videolink.split("/").last
    end
  end

end
