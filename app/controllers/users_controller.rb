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

  def user_project
  end
end
