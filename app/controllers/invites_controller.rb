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
    if @invite.valid?

      if !Invite.find_by(email: params[:email]).present?
            @invite.save
            #send the invite data to our mailer to deliver the email
            if @invite.custom_invitation == ""
              InviteMailer.new_user_invite(@invite, "http://localhost:3001/signup?invite_token=#{@invite.token}").deliver_now 
              render json: @invite
            else 
              InviteMailer.new_user_invite_custom(@invite, "http://localhost:3001/signup?invite_token=#{@invite.token}").deliver_now 
              #outputs -> http://localhost:3001.com/sign_up?invite_token=075eeb1ac0165950f9af3e523f207d0204a9efef
              render json: @invite
            end
      else
        render json: { header: "#{params[:email]} has already been invited to collaborate", error: @invite.errors.full_messages }, status: :bad_request 
      end
      
    else
      render json: { header: "You need to fulfill these #{@invite.errors.full_messages.count} requirements", error: @invite.errors.full_messages }, status: :bad_request 
    end
  end
end
