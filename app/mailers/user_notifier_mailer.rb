class UserNotifierMailer < ApplicationMailer
  default :from => 'no-reply@sirius.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email, :subject => "Thank you for getting SiriuS today!" )
  end

  def send_invitation_email(user)
    @user = user
    mail( :to => @user.email, :subject => "You have an invitation! Time to get SiriuS." )
  end
end
