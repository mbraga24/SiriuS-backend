class ProjectsController < ApplicationController
  def index
    projects = Project.all

    render json: projects
  end

  def create
    users = params[:assigned]
    project = Project.create( name: params[:name], description: params[:description], start_date: params[:startDate], due_date: params[:dueDate], admin_id: params[:admin] )
    assignedUsers = []

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
end

# name: fields.title,
# description: fields.description,
# startDate: startDate,
# dueDate: dueDate,
# admin: keyHolder.id