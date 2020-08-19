class ProjectsController < ApplicationController
  def index
    projects = Project.all

    render json: projects
  end

  def create
    # [1,2,3]

    byebug
    users = params[:users]
    project = Project.create(
      name: params[:name],
      description: params[:description],
      start_date: params[:startDate],
      due_date: params[:dueDate]
    )

    users.each do |user_id|
      user = User.find_by(id: user_id)
      ProjectTree.create(
        user: user,
        project: project
      ) 
    end

  end
end

# name: fields.title,
# description: fields.description,
# startDate: startDate,
# dueDate: dueDate,
# admin: keyHolder.id