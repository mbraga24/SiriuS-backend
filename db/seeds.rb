ProjectTree.destroy_all
ArquiveTree.destroy_all
Project.destroy_all
ArquiveProject.destroy_all
Document.destroy_all
User.destroy_all

# ========================================================================
#                             CREATE PROJECTS
# ========================================================================

project_1 = Project.create(
  name: "Rivver SaaS website",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
  start_date: "08/25/2020",
  due_date: "09/20/2020",
  finish_date: nil,
  done: false
)

project_2 = Project.create(
  name: "Rivver SaaS mobile app",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
  start_date: "08/27/2020",
  due_date: "09/20/2020",
  finish_date: Time.now.strftime("%m/%d/%Y"),
  done: false
)

project_3 = Project.create(
  name: "Rivver SaaS Website Menu",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
  start_date: "08/21/2020",
  due_date: "09/20/2020",
  finish_date: nil,
  done: false
)

# ========================================================================
#                             CREATE USERS
# ========================================================================

marlon = User.create(
  email: "admin@example.com",
  first_name: "Marlon",
  last_name: "Braga",
  company: "Design Monkey",
  job_title: "Project Manager",
  available: true,
  admin: true,
  password: "1L*vesalami"
)

mark = User.create(
  email: "markkoslo@example.com",
  first_name: "Mark",
  last_name: "Koslo",
  company: marlon.company,
  job_title: "Sr. Software Engineer",
  available: false,
  admin: false,
  password: "1L*vesalami"
)

franklin = User.create(
  email: "franklin@example.com",
  first_name: "Franklin",
  last_name: "Badu",
  company: marlon.company,
  job_title: "Jr. Software Engineer",
  available: false,
  admin: false,
  password: "1L*vesalami"
)

marcelo = User.create(
  email: "marcelo@example.com",
  first_name: "Marcelo",
  last_name: "Souza",
  job_title: "Sr. Software Engineer",
  company: marlon.company,
  available: false,
  admin: false,
  password: "1L*vesalami"
)

andrew = User.create(
  email: "andrew@example.com",
  first_name: "Andrew",
  last_name: "Cataluna",
  job_title: "Data Analist",
  company: marlon.company,
  available: false,
  admin: false,
  password: "1L*vesalami"
)

daniel = User.create(
  email: "daniel@example.com",
  first_name: "Daniel",
  last_name: "Costa",
  job_title: "UX Designer",
  company: marlon.company,
  available: false,
  admin: false,
  password: "1L*vesalami"
)

john = User.create(
  email: "johnathan@example.com",
  first_name: "Johnathan",
  last_name: "Kesviwich",
  job_title: "UI Designer",
  company: marlon.company,
  available: false,
  admin: false,
  password: "1L*vesalami"
)

will = User.create(
  email: "william@example.com",
  first_name: "William",
  last_name: "Scott",
  job_title: "UX Designer",
  company: marlon.company,
  available: false,
  admin: false,
  password: "1L*vesalami"
)

# ========================================================================
#                       SET UP MASSIVE ASSOCIATIONS
# ========================================================================

ALLOW_USERS = User.all.find_all do |user|
  (user.email != 'william@example.com') && (user.email != 'johnathan@example.com') && (user.email != 'admin@example.com') && (user.email != 'andrew@example.com')
end

def random_users 
  user_collection = []
  ALLOW_USERS.each do |u|
    [*0..1].sample == 1 ? user_collection << u : nil
  end
  return user_collection
end

def check_project_count_and_create(user, assign_project)
  if user.projects.count < 3 
    ProjectTree.create(
      user: user,
      project: assign_project
    )
  else
    return nil
  end
end

random_users().each do |user|
  check_project_count_and_create(user, project_1)
end

random_users().each do |user|
  check_project_count_and_create(user, project_2)
end

random_users().each do |user|
  check_project_count_and_create(user, project_3)
end

# ========================================================================
#     CREATE CUSTOM PROJECT ASSOCIATION FOR >JOHNATHAN< AND >WILLIAM<
# ========================================================================

Project.all.each do |pro|
  ProjectTree.create(
    user: will,
    project: pro
  )
end

Project.all.each do |pro|
  ProjectTree.create(
    user: john,
    project: pro
  )
end

arquived_project = ArquiveProject.create(
  name: "Rivver SaaS Menu Button",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
  start_date: "08/21/2020",
  due_date: "09/20/2020",
  finish_date: "11/13/2020"
)

ArquiveTree.create(
  user: User.second,
  arquive_project: arquived_project
)

ArquiveTree.create(
  user: User.third,
  arquive_project: arquived_project
)

# ========================================================================
#           CUSTOM USER/PROJECT/DOCUMENT CREATION FOR TESTING
# ========================================================================

ProjectTree.create(
    user: andrew,
    project: project_1
)

document_1 = Document.create(
  name: "Company Mission",
  url: "https://res.cloudinary.com/dloh9txdc/image/upload/v1604597369/Company_Mission_-_Demo_qdz8ym.pdf",
  user: marlon,
  project: project_1
)

document_2 = Document.create(
  name: "Project Requirements",
  url: "https://res.cloudinary.com/dloh9txdc/image/upload/v1604597179/Project_Requirements_-_Demo_zwe3qu.pdf",
  user: andrew,
  project: project_1
)

document_3 = Document.create(
  name: "Project Requirements",
  url: "https://res.cloudinary.com/dloh9txdc/image/upload/v1604597179/Project_Requirements_-_Demo_zwe3qu.pdf",
  user: marlon,
  project: project_2
)

document_4 = Document.create(
  name: "Project Requirements",
  url: "https://res.cloudinary.com/dloh9txdc/image/upload/v1604597179/Project_Requirements_-_Demo_zwe3qu.pdf",
  user: marlon,
  project: project_3
)


User.all.each do |user| 
  if user.projects.count < 3 && user.email != "admin@example.com"
    toggle_user = User.find_by(id: user[:id]) 
    toggle_user.toggle!(:available)
  end
end

puts "#{User.all.count} users created"
puts "#{Project.all.count} projects created"
puts "#{ArquiveTree.all.count} (ArquiveTree) user's associations arquived"
puts "#{ArquiveProject.all.count} (ArquiveProject) projects arquived"
puts "#{ProjectTree.all.count} user->project (ProjectTree) created"
puts "#{Document.all.count} Documents created"

puts "============================"
puts "          SEEDED"
puts "============================"