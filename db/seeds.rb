ProjectTree.destroy_all
Project.destroy_all
Document.destroy_all
User.destroy_all

# ========================================================================
#                             CREATE PROJECTS
# ========================================================================

project_1 = Project.create(
  name: "Riviera SaaS website",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
  start_date: "08-25-2020",
  due_date: "09-20-2020",
  finish_date: nil,
  done: false
)

project_2 = Project.create(
  name: "Riviera SaaS mobile app",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
  start_date: "08-27-2020",
  due_date: "09-20-2020",
  finish_date: Time.now.strftime("%m/%d/%Y"),
  done: true
)

project_3 = Project.create(
  name: "Riviera SaaS Website Menu",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
  start_date: "08-21-2020",
  due_date: "09-20-2020",
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
  company: "MonkeyGang Co,. Ltd.",
  job_title: "Project Manager",
  available: true,
  admin: true,
  password: "1L*vesalami"
)

mark = User.create(
  email: "markkoslo@example.com",
  first_name: "Mark",
  last_name: "Koslo",
  company: "MonkeyGang Co,. Ltd.",
  job_title: "Sr. Software Engineer",
  available: false,
  admin: false,
  password: "1L*vesalami"
)

franklin = User.create(
  email: "franklin@example.com",
  first_name: "Franklin",
  last_name: "Badu",
  company: "MonkeyGang Co,. Ltd.",
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
  company: "MonkeyGang Co,. Ltd.",
  available: false,
  admin: false,
  password: "1L*vesalami"
)

andrew = User.create(
  email: "andrew@example.com",
  first_name: "Andrew",
  last_name: "Cataluna",
  job_title: "Data Analist",
  company: "MonkeyGang Co,. Ltd.",
  available: true,
  admin: false,
  password: "1L*vesalami"
)

daniel = User.create(
  email: "daniel@example.com",
  first_name: "Daniel",
  last_name: "Costa",
  job_title: "UX Designer",
  company: "MonkeyGang Co,. Ltd.",
  available: false,
  admin: false,
  password: "1L*vesalami"
)

john = User.create(
  email: "johnathan@example.com",
  first_name: "Johnathan",
  last_name: "Kesviwich",
  job_title: "UI Designer",
  company: "MonkeyGang Co,. Ltd.",
  available: false,
  admin: false,
  password: "1L*vesalami"
)

will = User.create(
  email: "william@example.com",
  first_name: "William",
  last_name: "Scott",
  job_title: "UX Designer",
  company: "MonkeyGang Co,. Ltd.",
  available: false,
  admin: false,
  password: "1L*vesalami"
)

# ========================================================================
#           CUSTOM USER/PROJECT/DOCUMENT CREATION FOR TESTING
# ========================================================================
# name: "Just Some Flowers",
# url: "https://res.cloudinary.com/dloh9txdc/image/upload/v1602009325/Company_Intro_b5sxcw.pdf",

ProjectTree.create(
    user: andrew,
    project: project_1
  )

document_1 = Document.create(
  name: "Company Intro",
  url: "https://res.cloudinary.com/dloh9txdc/image/upload/v1598121663/sample.jpg",
  user: andrew,
  project: project_1
)

# ========================================================================
#                       SET UP CUSTOM ASSOCIATIONS
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

def checkProjectCount(user, assign_project)
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
  checkProjectCount(user, project_1)
end

random_users().each do |user|
  checkProjectCount(user, project_2)
end

random_users().each do |user|
  checkProjectCount(user, project_3)
end

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

User.all.each do |user| 
  if user.projects.count < 3 && user.email != "admin@example.com"
    toggle_user = User.find_by(id: user[:id]) 
    toggle_user.toggle!(:available)
  end
end
puts "#{User.all.count} users created"
puts "#{Project.all.count} projects created"
puts "#{ProjectTree.all.count} user->project (ProjectTree) created"
puts "#{Document.all.count} Documents created"

puts "============================"
puts "          SEEDED"
puts "============================"