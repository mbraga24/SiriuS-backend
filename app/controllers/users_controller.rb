class UsersController < ApplicationController
  def index
    users = User.all

    render json: users
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user
  end

  def admin
    user = User.find_by(id: params[:id])
    render json: { user: userSerializer.new(user) }
  end

  def create 
    # create user
    user = User.create(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], company: params[:company], job_title: params[:job_title], password: params[:password])

    # # if user was successfully created
    if user.valid? 
    
    #    # if user is valid collect skills from params
    #   top_skills = Skill.all.find_all { |skill| params[:topSkills].include?(skill[:text]) }

    #   # if user is valid create association between new user and skills
    #   top_skills.each do |topSkill|
    #     UserSkill.create(
    #       user: user,
    #       skill: topSkill
    #     )
      # end

    #   # encrypt the user id ====> token = JWT.encode payload, password parameter, 'algorithm'
    #   token = JWT.encode({ user_id: user.id }, "not_too_safe", "HS256")

    #   # if it validates to true renders json: user & token ====> run user explicitly through serializer
      # render json: { user: userSerializer.new(user), token: token }
      byebug
      render json: user, status: :created
    else

    #   # if user is not valid - render error messages (rails validation messages) and status code
    #   render json: { header: "You need to fulfill these #{user.errors.full_messages.count} password requirements", error: user.errors.full_messages }, status: :bad_request 
      render json: { header: "You need to fulfill these #{user.errors.full_messages.count} password requirements", error: user.errors.full_messages }, status: :bad_request 

    end
  end

  def login 
    # byebug
    # find user by email
    user = User.find_by(email: params[:email])

    # validates user and password (authentication)
    if user && user.authenticate(params[:password])
      # byebug
      # encrypt the user id ====> token = JWT.encode payload, password parameter, 'algorithm'
      # token = JWT.encode({ user_id: user.id }, "not_too_safe", "HS256")

      # if it validates to true renders json: user & token ====> run user explicitly through serializer
      # render json: { user: userSerializer.new(user), token: token, header: "Welcome, #{user.first_name} #{user.last_name}!", message: [], type: "success" }
      render json: user

      # default render before authentication ====> implicitly run through serializer
      # render json: user
    else
      # if user is not valid send error message and status
      render json: { header: "Uh-oh! Invalid email or password", message: [], type: "error" }, status: :unauthorized
    end
  end

  def autologin
      # byebug
  #   # extract the auth header
  #   auth_header = request.headers['Authorization']

  #   # split the string and get the encrypted token we need
  #   token = auth_header.split(" ")[1]

  #   # decode token with JWT library
  #   decoded_token = JWT.decode(token, "not_too_safe", true, { algorthim: "HS256"})

  #   # get the user_id from decoded token
  #   user_id = decoded_token[0]["user_id"]

  #   # find user by id 
  #   # user = user.find_by(id: user_id)
    user = User.find_by(id: params[:id])

  #   # validates user
    if user
      render json: user
    else
  #     # if user doesn't validate renders error message and status
      render json: { message: "You are not logged in" }, status: :unauthorized
    end
  end

  def update
    user = User.find_by(id: params[:id])

    # needs work
    if user.valid? && user.projects.count == 2
      user.update(available: false)
      
      render json: user
    elsif user.valid? &&  user.projects.count < 2
      render json: user
    else
      render json: {message: "Something went wrong!"}, status: :bad_request
    end
  end
end
