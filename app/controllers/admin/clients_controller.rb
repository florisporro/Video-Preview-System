class Admin::ClientsController < ApplicationController
  before_filter :check_login
  before_filter :check_admin_rights


  def index
    @clients = User.includes(:videos)
    @videos = Video.all
  end

  def create
  	if @client = User.create(params[:client].permit(:name, :email, :password, :admin)) 
  		flash[:notice] = "Succesfully created user " + @client.name + "."
  	else
    		# error handling
  	end

    respond_to do |format|
      format.html { redirect_to admin_url }
      format.js
    end
  end

  def update
    @user = User.find(params[:id])


    if !params[:client].nil?
      User.update(params[:id], params[:client].permit(:name, :email, :password, :admin))
    end

    respond_to do |format|
      format.html { redirect_to admin_url }
      format.js
    end
    
  end

  def destroy
    # flash[:alert] = "Current user = " + @_current_user.id.to_s + @_current_user.name + params[:id].to_s
  	if params[:id].to_i == @_current_user.id
      flash[:alert] = "You cannot delete yourself."
    else
      @client = User.destroy(params[:id])
      flash[:notice] = "Succesfully deleted user " + @client.name + "."
    end

    respond_to do |format|
      format.js
    end
  end

  def mail
    @clientdetails = User.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def mail_send

    NewVideoNotify.new_video_notify(User.find(params[:id])).deliver

    respond_to do |format|
      format.js
    end
  end
end
