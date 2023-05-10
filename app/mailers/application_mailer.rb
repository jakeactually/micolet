class ApplicationMailer < ActionMailer::Base
  default from: "info@micolet.com"
  layout "mailer"

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome #{@user.email} !")
  end
end
