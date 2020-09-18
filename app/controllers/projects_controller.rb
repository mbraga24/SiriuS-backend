class ProjectsController < ApplicationController
  def index
    projects = Project.all

    render json: projects
  end

  def show
    project = Project.find_by(id: params[:id])

    render json: project
  end

  def create
    assignedUsers = []
    users = params[:assigned]
    project = Project.create( 
      name: params[:name], 
      description: params[:description], 
      start_date: params[:startDate], 
      due_date: params[:dueDate], 
      done: false 
    )

    if project.valid? 
      users.each do |user_id|
        user = User.find_by(id: user_id.to_i)
        ProjectTree.create(
          user: user,
          project: project
        ) 

        if user.projects.count === 3 
          user.update(available: false)
        end 

        assignedUsers << UserSerializer.new(user)
        # byebug
      end

      render json: { project: project, users: assignedUsers }
    else
      render json: { error: project.errors.full_messages }, status: :bad_request
    end
    # byebug
  end

  def complete
    project = Project.find_by(id: params[:id])
    project.toggle!(:done)
    render json: project
  end

  def delete_all_complete
    # destroy all projects
  end
end
