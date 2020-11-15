class ArquiveProjectsController < ApplicationController
  def index
    archived_projects = ArquiveProject.all.order("id DESC")
    render json: archived_projects
  end

  def show
    archived_project = ArquiveProject.find_by(id: params[:id])
    render json: archived_project
  end

  def create
    archived_project = ArquiveProject.create(
      name: params[:name],
      description: params[:description],
      start_date: params[:start_date],
      due_date: params[:due_date],
      finish_date: Time.now.strftime("%m/%d/%Y")
    )

    params[:users].each do |user|
      ArquiveTree.create(
        user: User.find_by(email: user[:email]),
        arquive_project: archived_project
      )  
    end
    render json: { archived_project: ArquiveProjectSerializer.new(archived_project) }, status: :ok
  end
  
  def destroy
    project = ArquiveProject.find_by(id: params[:id])
    project_id = project.id
    project.destroy
    render json: { header: "The project was deleted successfully", projectId: project_id }, status: :ok
  end  
end
