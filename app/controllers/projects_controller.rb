class ProjectsController < ApplicationController
  def index
    projects = Project.all.order("id DESC")
    render json: projects
  end

  def show
    project = Project.find_by(id: params[:id])
    render json: project
  end

  def update 
    
    updated_users = []
    users = params[:assigned]
    project = Project.find_by(id: params[:id])
    
    project.update( 
      name: params[:name], 
      description: params[:description], 
      start_date: params[:startDate], 
      due_date: params[:dueDate]
      )

    if !project.errors.any?
      
      project.users.each do |user|
        if !users.include? user.id
          if user.available == false && user.projects.count == 3
            user.toggle!(:available)
          end
          ProjectTree.find_by(user: user, project: project).destroy
    
          updated_users << UserSerializer.new(user)
        end
      end
      
      user = nil
      users.each do |u|
        user_int = u.to_i
        user = User.find_by(id: user_int)
        
        if !project.users.find_by(id: user_int)
          if user.projects.count == 2
            user.toggle!(:available)
          end
          ProjectTree.create(user: user, project: project)
    
          updated_users << UserSerializer.new(user)
        end
      end


      updated_project = Project.find_by(id: params[:id])

      render json: { project: ProjectSerializer.new(updated_project), users: updated_users }, status: :accepted
    else
      render json: { header: "The following #{project.errors.count} errors occurred:", error: project.errors.full_messages }, status: :bad_request 
    end

  end

  def create
    assigned_users = []
    users = params[:assigned]

    # start_date = "11-28-2020 - 11-30-2020".split(/,| - /)[0]
    # dute_date = "11-28-2020 - 11-30-2020".split(/,| - /)[1]
    # start_date = dateOne.split("-").join("/")
    # dute_date = dateTwo.split("-").join("/")  

    project = Project.create( 
      name: params[:name], 
      description: params[:description], 
      start_date: params[:startDate], 
      due_date: params[:dueDate]
    )

    users.each do |user_id|
      user = User.find_by(id: user_id.to_i)
      if user.projects.count == 2
        
        ProjectTree.create(
          user: user,
          project: project
        ) 
          user.toggle!(:available)
          assigned_users << UserSerializer.new(user)
      else
        ProjectTree.create(
          user: user,
          project: project
        ) 
        assigned_users << UserSerializer.new(user)
      end
    end

    if project.valid?
      render json: { project: ProjectSerializer.new(project), users: assigned_users }, status: :created
    else
      render json: { header: "The following #{project.errors.count} errors occurred:", error: project.errors.full_messages }, status: :bad_request 
    end
  end

  def add_users_to_project
    project = Project.find_by(id: params[:projectId])
    new_users = []

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

  # A completed project will be destroyed and a copy will be made to the ArchiveProject db
  def destroy
    users = []
    documents = []

    completed_project = Project.find_by(id: params[:id])
    
    # store all documents
    completed_project.documents.each do |doc|
      documents << DocumentSerializer.new(doc)
    end
    # byebug
    # change users's availability and store users
    completed_project.users.each do |user|
      if user.available == false
        user.toggle!(:available)
      end
      users << UserSerializer.new(user)
    end

    # delete all user's associations with project
    completed_project.users.each do |user|
      ProjectTree.find_by(user: user, project: completed_project).destroy
    end
    # byebug
    completed_project.destroy
    # byebug
    render json: { project: ProjectSerializer.new(completed_project), users: users, documents: documents }, status: :ok
  end
end
