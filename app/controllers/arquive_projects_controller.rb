class ArquiveProjectsController < ApplicationController
  def index
    arquived_projects = ArquiveProject.all.order("id DESC")
    render json: arquived_projects
  end

  def show
    arquived_project = ArquiveProject.find_by(id: params[:id])
    render json: arquived_project
  end

  def create
    arquived_project = ArquiveProject.create(
      name: params[:name],
      description: params[:description],
      start_date: params[:start_date],
      due_date: params[:due_date],
      finish_date: Time.now.strftime("%m/%d/%Y")
    )

    params[:users].each do |user|
      ArquiveTree.create(
        user: User.find_by(email: user[:email]),
        arquive_project: arquived_project
      )  
    end
    render json: { arquived_project: ArquiveProjectSerializer.new(arquived_project) }, status: :ok
  end
  
  def destroy
    project = ArquiveProject.find_by(id: params[:id])
    project_id = project.id
    project.destroy
    render json: { header: "The project was deleted successfully", projectId: project_id }, status: :ok
  end  
end
