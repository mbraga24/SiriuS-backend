class UserNotifierMailer < ApplicationMailer
  default :from => 'no-reply@sirius.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user, admin)
    @user = user
    @admin = admin
    mail( :to => @user.email, :subject => "Thank you for getting SiriuS!" )
  end
end
