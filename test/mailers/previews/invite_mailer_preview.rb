# Preview all emails at http://localhost:3000/rails/mailers/invite_mailer
class InviteMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invite_mailer/new_user_invite
  def new_user_invite
    InviteMailer.new_user_invite
  end

  def new_user_invite_custom
    InviteMailer.new_user_invite_custom
  end

end
