class InvitesController < ApplicationController
  def create
    @invite = Invite.new( email: params[:email] ) # Make a new Invite
    @invite.sender_id = params[:current_user][:id] # set the sender to the current user
    if @invite.save
      byebug
      #send the invite data to our mailer to deliver the email
       InviteMailer.new_user_invite(@invite, "http://localhost:3001/signup?invite_token=#{@invite.token}").deliver 
       #outputs -> http://localhost:3001.com/sign_up?invite_token=075eeb1ac0165950f9af3e523f207d0204a9efef
    else
      puts "============> ERROR "
      byebug
       # oh no, creating an new invitation failed
    end
  end
end
