class EmailChangeMailer < ApplicationMailer
  def new_email(prev_email, user, link)
    @prev_email = prev_email
    @user = user
    @link = link
    mail( :to => @user.email, :subject => "Thank you for updating your email" )
  end
end
