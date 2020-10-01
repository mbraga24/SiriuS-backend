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
    # byebug
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

  # def delete_all_complete
  #   # collect all projects before destroying
  #   projects = Project.all.select{ |project| project.done } 
  
  #   # collect all users who are unavailable for working 3 projects
  #   users = projects.collect do |project|
  #     project.users.select do |user|
  #       if user.available == false
  #         user.toggle!(:available)
  #       end
  #     end
  #   end[0]

  #   # delete all projects that are true
  #   Project.all.each do |project| 
  #     if project.done == true 
  #       project.destroy
  #     end
  #   end

  #   render json: { header: "Completed projects deleted successfully", available_users: users }, status: :ok
  # end
end
