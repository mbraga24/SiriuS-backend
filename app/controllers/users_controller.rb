class UsersController < ApplicationController

  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user
  end

  def update
    user = User.find_by(id: params[:id])
    current_email = user.email

    user.update( 
      first_name: params[:firstName], 
      last_name: params[:lastName], 
      company: params[:company], 
      job_title: params[:jobTitle],
      email: params[:email] 
    )
    if user.valid?
      log_out = false
      success = "You're all set. Your account has been updated"
      user = User.find_by(id: params[:id])
      
      if current_email != params[:email] 
        log_out = true
        success = "We see you changed your email. Please log in with your new email. We're signing you out..."
        link = "http://localhost:3001/login"
        EmailChangeMailer.new_email(current_email, user, link).deliver_later
      end

      render json: { user: user, logOut: log_out, success: success}, status: :accepted
      
    else 
      render json: { header: "#{user.errors.full_messages.count} #{user.errors.full_messages.count > 1 ? "errors" : "error"} occurred:", error: user.errors.full_messages }, status: :not_acceptable 
    end
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
          token = JWT.encode({ user_id: user.id }, "not_too_safe", "HS256")
          UserNotifierMailer.send_signup_email(@user, @admin).deliver
          # destroy invitation once user was created
          invite.destroy
          render json: { user: UserSerializer.new(@user), token: token, invite: InviteSerializer.new(invite) }, status: :created
      else
        render json: { header: "Please fulfill these #{@user.errors.full_messages.count} requirements", error: @user.errors.full_messages }, status: :bad_request 
      end
    else
      # else create new admin
      @admin = User.new(user_admin_params)
      @admin.admin = true
      if @admin.save 
        # create sign_up_mailer and send email to a new Admin
        render json: { user: UserSerializer.new(@admin) }, status: :created
      else  
        render json: { header: "You need to fulfill these #{@admin.errors.full_messages.count} password requirements", error: @admin.errors.full_messages }, status: :bad_request 
      end
    end
  end

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

  def remove_project
    project = Project.find_by(id: params[:project_id])
    user = User.find_by(id: params[:user_id])
    
    # change user's availability if user has a total of 3 projects 
    if user.projects.count === 3 
      user.toggle!(:available)
    end
    # delete the association between the given project and user 
    ProjectTree.find_by(user_id: user.id, project_id: project.id).destroy

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
