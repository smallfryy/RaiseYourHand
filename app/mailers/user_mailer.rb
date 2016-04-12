class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'http://Raise-Your-Hand.herokuapp.com'
    mail(to @user.email, subject: "Thanks for Logging In")
  end
end
