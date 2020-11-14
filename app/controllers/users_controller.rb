class UsersController < ApplicationController
  def index
    users = User.all

    render json: users
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user
  end

  def create 
    # if invite_token exists create user 
    if user_invite_token[:invite_token] && Invite.find_by(token: user_invite_token[:invite_token]).present?
      
      invite = Invite.find_by(token: user_invite_token[:invite_token])
      @admin = invite.sender
      @user = User.new(user_params)
      @user.company = @admin.company

      if @user.valid? 
        @user.save
          # encrypt the user id ====> token = JWT.encode payload, password parameter, 'algorithm'
          # token = JWT.encode({ user_id: user.id }, "not_too_safe", "HS256")
    
          # if it validates to true renders json: user & token ====> run user explicitly through serializer
          # render json: { user: userSerializer.new(user), token: token }
          UserNotifierMailer.send_signup_email(@user, @admin).deliver
          # destroy invitation once user was created
          invite.destroy
          render json: { user: UserSerializer.new(@user), invite: InviteSerializer.new(invite) }, status: :created
      else
        # byebug
        render json: { header: "You need to fulfill these #{@user.errors.full_messages.count} password requirements", error: @user.errors.full_messages }, status: :bad_request 
      end
    else
      # else create new admin
      @admin = User.new(user_admin_params)
      @admin.admin = true
      if @admin.save 
        # UserNotifierMailer.send_signup_email(@admin).deliver
        render json: { user: UserSerializer.new(@admin) }, status: :created

      else  
        render json: { header: "You need to fulfill these #{@admin.errors.full_messages.count} password requirements", error: @admin.errors.full_messages }, status: :bad_request 
      end
    end
  end

  def login 
    # byebug
    # find user by email
    user = User.find_by(email: params[:email])
    # byebug
    # validates user and password (authentication)
    if user && user.authenticate(params[:password])
      # byebug
      # encrypt the user id ====> token = JWT.encode payload, password parameter, 'algorithm'
      # token = JWT.encode({ user_id: user.id }, "not_too_safe", "HS256")

      # if it validates to true renders json: user & token ====> run user explicitly through serializer
      # render json: { user: userSerializer.new(user), token: token, header: "Welcome, #{user.first_name} #{user.last_name}!", message: [], type: "success" }
      render json: { user: UserSerializer.new(user) }
    else
      render json: { header: "Uh-oh! Invalid email or password", message: [], type: "error" }, status: :unauthorized
    end
  end

  def autologin
  # byebug
  # # extract the auth header
  # auth_header = request.headers['Authorization']

  # # split the string and get the encrypted token we need
  # token = auth_header.split(" ")[1]

  # # decode token with JWT library
  # decoded_token = JWT.decode(token, "not_too_safe", true, { algorthim: "HS256"})

  # # get the user_id from decoded token
  # user_id = decoded_token[0]["user_id"]

  # # find user by id 
  # # user = user.find_by(id: user_id)
    user = User.find_by(id: params[:id])

    if user
      render json: user
    else
      render json: { message: "You are not logged in" }, status: :unauthorized
    end
  end

  def update
    user = User.find_by(id: params[:id])

    if user.valid? && user.projects.count == 2
      user.toggle!(:available)
      
      render json: user
    elsif user.valid? &&  user.projects.count < 2
      render json: user
    else
      render json: { message: "Something went wrong!" }, status: :bad_request
    end
  end

  def remove_project
    # find project and user by their id
    project = Project.find_by(id: params[:project_id])
    user = User.find_by(id: params[:user_id])
    
    # change user's availability if user has a total of 3 projects 
    if user.projects.count === 3 
      user.toggle!(:available)
    end
    # delete the association between the given project and user 
    ProjectTree.find_by(user_id: user.id, project_id: project.id).destroy

    # return updated user and project to update redux store in the frontend
    render json: { user: UserSerializer.new(user), project: ProjectSerializer.new(project) }
  end

  def destroy
    user = User.find_by(id: params[:id])

    collectProjects = []
    collectDocuments = []

    user.projects.each do |pro|
      collectProjects << ProjectSerializer.new(pro)
    end

    user.documents.each do |doc|
      collectDocuments << DocumentSerializer.new(doc)
    end

    user.destroy
    render json: { user: UserSerializer.new(user), projects: collectProjects, documents: collectDocuments }
  end

  private
    def user_invite_token
      params.require(:user).permit(:invite_token)
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :job_title, :password)
    end

    def user_admin_params
      params.require(:user).permit(:email, :first_name, :last_name, :job_title, :company, :password)
    end
end
