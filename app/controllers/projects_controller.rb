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

    users.each do |user_id|
      # find user by id
      user = User.find_by(id: user_id.to_i)
      if user.projects.count == 2
        
        ProjectTree.create(
          user: user,
          project: project
        ) 
          
          user.toggle!(:available)
          assignedUsers << UserSerializer.new(user)
      else
        ProjectTree.create(
          user: user,
          project: project
        ) 
        assignedUsers << UserSerializer.new(user)
      end
    end
    render json: { project: ProjectSerializer.new(project), users: assignedUsers }, status: :created
  end

  def add_new_users
    new_users = []
    project = Project.find_by(id: params[:projectId])

    params[:users].each do |u_id|
      user = User.find_by(id: u_id)
      # if user is assigned to 2 projects make it unavailable
      if user.projects.count == 2
        ProjectTree.create(
          user: user,
          project_id: project.id
        )
        # toggle availability
        user.toggle!(:available)

        new_users << UserSerializer.new(user)
      else 
        ProjectTree.create(
          user: user,
          project_id: project.id
        )
        new_users << UserSerializer.new(user)
      end 

    end

    render json: { users: new_users, project: ProjectSerializer.new(project) }
  end

  def download_zip
    project = Project.find_by(id: params[:id])
      # compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      #   zos.put_next_entry "TESTING #{project.name}-#{project.id}.json"
      #   zos.print project.to_json(only: [:name])
      # end
      # compressed_filestream.rewind
      # send_data compressed_filestream.read, filename: "projects.zip"

      stringio = Zip::OutputStream.write_buffer do |zio|
        zio.put_next_entry "#{project.name}-#{project.id}.json"
        zio.print project.to_json(only: [:name, :description])

        # dec_pdf = render_to_string :pdf => "project-#{project.id}.pdf", :file => '/siri-us-frontend/components/ShowProject.js', :template => "project/done/#{project.id}", :formats => 'json', :locals => {project: project}, :layouts => false
        dec_pdf = render_to_string :pdf => "project-#{project.id}.pdf", :url => "project/done/:id", :format => :html, :locals => {project: project}, :layouts => false
        zio.put_next_entry("project-#{project.id}.pdf")
        zio << dec_pdf
      end
      stringio.rewind
      binary_data = stringio.sysread
      send_data(binary_data, :type => 'application/zip', :filename => "projects.zip")
  end

  # ATTEMPTS:
  # /download/#{project.id}
  # "siri-us-frontend/components/ShowProject.js"
  # "project/done/#{project.id}"
  # "http://localhost:3001/project/done/#{project.id}"

  def complete
    project = Project.find_by(id: params[:id])
    project.toggle!(:done)
    # set the date when the project was completed
    project[:finish_date] = Time.now.strftime("%m/%d/%Y")
    render json: {project: ProjectSerializer.new(project)}, status: :ok
  end

  def destroy
    users = []
    project = Project.find_by(id: params[:id])
    project_id = project.id
    project.users.each do |user|
      if user.available == false
        user.toggle!(:available)
        users << UserSerializer.new(user)
      end
    end
    project.destroy
    render json: { header: "The project was deleted successfully", projectId: project_id, users: users }, status: :ok
  end
end
