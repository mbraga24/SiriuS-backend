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
          InviteMailer.new_user_invite(@invite, "http://localhost:3001/signup?invite_token=#{@invite.token}").deliver
        else 
          InviteMailer.new_user_invite_custom(@invite, "http://localhost:3001/signup?invite_token=#{@invite.token}").deliver
        end
        render json: { invite: InviteSerializer.new(@invite) }
      else
        render json: { header: "#{params[:email]} has already been invited to collaborate", error: @invite.errors.full_messages }, status: :bad_request 
      end
    else
      render json: { header: "You need to fulfill these #{@invite.errors.full_messages.count} requirements", error: @invite.errors.full_messages }, status: :bad_request 
    end

  end

  def destroy
    invite = Invite.find_by(id: params[:id])
    invite.destroy
    render json: { invite: InviteSerializer.new(invite) }
  end

end
