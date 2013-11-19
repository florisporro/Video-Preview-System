class AdminController < ApplicationController
  before_filter :check_login
  before_filter :check_admin_rights
  before_filter :redirect

  def redirect
    if !@_current_user.admin
      redirect_to login_url
    else
      redirect_to '/admin/clients/'
    end
  end
  
end
