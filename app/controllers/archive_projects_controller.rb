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
      name: params[:project][:name],
      description: params[:project][:description],
      start_date: params[:project][:start_date],
      due_date: params[:project][:due_date],
      archived_date: Time.now.strftime("%m/%d/%Y")
    )
    params[:project][:users].each do |user|
      ArchiveTree.create(
        user: User.find_by(email: user[:email]),
        archive_project: archived_project
      )  
    end
    
    params[:documents].each do |doc|
      ArchiveDocument.create(
        name: doc[:name],
        url: doc[:url],
        user: User.find_by(id: doc[:user][:id]),
        archive_project: archived_project
      )  
    end

    render json: { archived_project: ArchiveProjectSerializer.new(archived_project) }, status: :ok
  end

  def download_zip
    archived_project = ArchiveProject.find_by(id: params[:id])
      stringio = Zip::OutputStream.write_buffer do |zio|
        # create text file with all the project's details
        zio.put_next_entry "#{archived_project.name}-#{archived_project.id}.txt"
        zio.write "Project Name: \n"
        zio.print "#{archived_project[:name]} \n"
        zio.write "Project Description: \n"
        zio.print "#{archived_project[:description]} \n"
        zio.write "Project Start Date: \n"
        zio.print "#{archived_project[:start_date]} \n"
        zio.write "Project Due Date: \n"
        zio.print "#{archived_project[:due_date]} \n"
        zio.write "Archived Date: \n"
        zio.print "#{archived_project[:archived_date]} \n"   
        
        # create .json file with all the project's details
        zio.put_next_entry "#{archived_project.name}-#{archived_project.id}.json"
        zio.print archived_project.to_json(only: [:name, :description, :start_date, :due_date, :archived_date])
      end
      stringio.rewind
      binary_data = stringio.sysread
      send_data(binary_data, :type => 'application/zip', :filename => "Project-#{archived_project.name}.zip")
  end
  
  def destroy
    archiveProject = ArchiveProject.find_by(id: params[:id])

    archiveProject.users.each do |user|
      archv = ArchiveTree.find_by(
        user: user,
        archive_project: archiveProject
      )
      archv.destroy
    end

    archive_id = archiveProject.id
    archiveProject.destroy
    render json: { header: "The project was deleted from your archive successfully", archiveId: archive_id }, status: :ok
  end  
  
end
