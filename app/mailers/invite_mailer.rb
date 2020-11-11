class InviteMailer < ApplicationMailer
  def new_user_invite(invite, link)
    @invite = invite
    @link = link

    mail( :to => @invite.email, :subject => "You have an invitation to get SiriuS!" )
  end
end
