class ProjectsController < ApplicationController
  def index
    projects = Project.all.order("id DESC")
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
      finish_date: nil,
      done: false 
    )

    users.each do |user_id|
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
      stringio = Zip::OutputStream.write_buffer do |zio|
        # create text file with all the project's details
        zio.put_next_entry "#{project.name}-#{project.id}.txt"
        zio.write "Project Name: \n"
        zio.print "#{project[:name]} \n"
        zio.write "Project Description: \n"
        zio.print "#{project[:description]} \n"
        zio.write "Project Start Date: \n"
        zio.print "#{project[:start_date]} \n"
        zio.write "Project Due Date: \n"
        zio.print "#{project[:due_date]} \n"
        zio.write "Project Closed Date: \n"
        zio.print "#{project[:finish_date]} \n"   
        
        # create .json file with all the project's details
        zio.put_next_entry "#{project.name}-#{project.id}.json"
        zio.print project.to_json(only: [:name, :description, :start_date, :due_date, :finish_date])
      end
      stringio.rewind
      binary_data = stringio.sysread
      send_data(binary_data, :type => 'application/zip', :filename => "project.zip")
  end

  def complete
    project = Project.find_by(id: params[:id])
    project.toggle!(:done)
    # set the date when the project was completed
    project[:finish_date] = Time.now.strftime("%m/%d/%Y")
    render json: { project: ProjectSerializer.new(project) }, status: :ok
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
