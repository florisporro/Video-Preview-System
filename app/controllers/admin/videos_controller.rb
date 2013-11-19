class Admin::VideosController < ApplicationController
  before_filter :check_login
  before_filter :check_admin_rights

  def index
    if params[:client_id].nil?
      redirect_to admin_url
    end
    @user = User.includes(:videos).find(params[:client_id])

  end

  def create
    params[:video][:user_id] = params[:client_id]
  	if @video = Video.create(params[:video].permit(:title, :description, :user_id, :videolink)) 
  	
    redirect_to admin_client_videos_path(params[:client_id])
	else
  		# error handling
	end
  end

  def update
    @video = Video.find(params[:id])

    if !params[:video].nil?
      Video.update(@video.id, params[:video].permit(:title, :description, :videolink))
    end

    respond_to do |format|
      format.html { redirect_to admin_client_videos_path(params[:client_id]) }
      format.js
    end
    

  end

  def destroy
  	Video.destroy(params[:id])

    respond_to do |format|
      format.js
    end
  end
end
