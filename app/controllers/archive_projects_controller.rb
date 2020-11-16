class ArchiveProjectsController < ApplicationController
  def index
    archived_projects = ArchiveProject.all.order("id DESC")
    render json: archived_projects
  end

  def show
    archived_project = ArchiveProject.find_by(id: params[:id])
    render json: archived_project
  end

  def create
    archived_project = ArchiveProject.create(
      name: params[:name],
      description: params[:description],
      start_date: params[:start_date],
      due_date: params[:due_date],
      archived_date: Time.now.strftime("%m/%d/%Y")
    )

    params[:users].each do |user|
      ArchiveTree.create(
        user: User.find_by(email: user[:email]),
        archive_project: archived_project
      )  
    end
    render json: { archived_project: ArchiveProjectSerializer.new(archived_project) }, status: :ok
  end
  
  def destroy
    archiveProject = ArchiveProject.find_by(id: params[:id])
    
    # archiveProject.documents.each do |user|
    #   archv = ArchiveDocuments.find_by(
    #     user: user,
    #     archive_project: archiveProject
    #   )
    #   archv.destroy
    # end

    archiveProject.users.each do |user|
      archv = ArchiveTree.find_by(
        user: user,
        archive_project: archiveProject
      )
      archv.destroy
    end

    archive_id = archiveProject.id
    archiveProject.destroy
    render json: { header: "The project was deleted successfully", archiveId: archive_id }, status: :ok
  end  
end
