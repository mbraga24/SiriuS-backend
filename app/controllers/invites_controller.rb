class InvitesController < ApplicationController
  def index
    invites = Invite.all

    render json: invites
  end
  def create
    @invite = Invite.new( 
      email: params[:email], 
      first_name: params[:first_name],
      last_name: params[:last_name], 
      company: params[:company], 
      custom_invitation: params[:custom_invitation],
      sender_id: params[:current_user_id]
    )
    # byebug
    if @invite.save
      # byebug
      #send the invite data to our mailer to deliver the email
      if @invite.custom_invitation == ""
        InviteMailer.new_user_invite(@invite, "http://localhost:3001/signup?invite_token=#{@invite.token}").deliver_now 
      else 
        InviteMailer.new_user_invite_custom(@invite, "http://localhost:3001/signup?invite_token=#{@invite.token}").deliver_now 
        #outputs -> http://localhost:3001.com/sign_up?invite_token=075eeb1ac0165950f9af3e523f207d0204a9efef
      end
      render json: @invite
    else
      puts "============> ERROR "
      # byebug
       # oh no, creating an new invitation failed
    end
  end
end
