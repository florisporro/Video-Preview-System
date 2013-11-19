class NewVideoNotify < ActionMailer::Base
  default from: "info@aviofilm.com"

  def new_video_notify(user)
  	@user = user
  	@unseen = @user.videos.where(created_at: (@user.updated_at)..Time.now).count

    if @unseen == 0
      @unseen = ''
    end
    mail(to: @user.email, subject: 'Aviofilm Preview System - New preview videos available for review')
  end
end
