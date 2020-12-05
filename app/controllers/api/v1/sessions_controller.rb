class Api::V1::SessionsController < ApplicationController

  def login 
    if !params[:email].blank? && !params[:password].blank?

      @user = User.find_by(email: params[:email])
    
      if @user && @user.authenticate(params[:password])
        # encrypt the user id ====> token = JWT.encode payload, password parameter, 'algorithm'
        token = JWT.encode({ user_id: @user.id }, "not_too_safe", "HS256")
        
        # "Welcome, #{user.first_name} #{user.last_name}!"
        render json: { user: UserSerializer.new(@user), token: token }, status: :accepted
      else
        render json: { header: "Something went wrong with your credentials.", message: [], type: "error" }, status: :unauthorized
      end

    else 
      render json: { header: "Please enter email and password", message: [], type: "error" }, status: :unauthorized
    end
  end

  def autologin
    # byebug
    # extract the auth header
    auth_header = request.headers['Authorization']

    # split the string and get the encrypted token we need
    token = auth_header.split(" ")[1]

    # decode token with JWT library
    decoded_token = JWT.decode(token, "not_too_safe", true, { algorthim: "HS256"})

    # get the user_id from decoded token
    user_id = decoded_token[0]["user_id"]

    # find user by id 
    user = User.find_by(id: user_id)

    if user
      render json: user
    else
      render json: { message: "You are not logged in" }, status: :unauthorized
    end
  end

end
