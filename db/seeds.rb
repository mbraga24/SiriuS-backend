ProjectTree.destroy_all
Project.destroy_all
User.destroy_all

project_1 = Project.create(
  name: "Riviera SaaS website",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
  start_date: "08-25-2020",
  due_date: "09-20-2020",
  done: false
)

project_2 = Project.create(
  name: "Riviera SaaS mobile app",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
  start_date: "08-27-2020",
  due_date: "09-20-2020",
  done: true
)

project_3 = Project.create(
  name: "Riviera SaaS Website Menu",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
  start_date: "08-21-2020",
  due_date: "09-20-2020",
  done: false
)

# project_4 = Project.create(
#   name: "Finish Resume",
#   description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
#   start_date: "08-21-2020",
#   due_date: "09-20-2020",
#   done: false
# )

# project_5 = Project.create(
#   name: "Finish editing projects",
#   description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding morning stand-up meetings for about 10-15 minutes to discuss our daily goals. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me any time of the day: (333)-444-9009",
#   start_date: "08-21-2020",
#   due_date: "09-20-2020",
#   done: false
# )

document_1 = Document.create(
  name: "Just Some Flowers",
  url: "https://res.cloudinary.com/dloh9txdc/image/upload/v1598121663/sample.jpg",
  project_id: project_1.id
)

marlon = User.create(
  email: "admin@example.com",
  password: "12345",
  first_name: "Marlon",
  last_name: "Braga",
  company: "MonkeyGang Co,. Ltd.",
  job_title: "Project Manager",
  available: true,
  admin: true
)

mark = User.create(
  email: "mark@example.com",
  password: "12345",
  first_name: "Mark",
  last_name: "Koslo",
  company: "MonkeyGang Co,. Ltd.",
  job_title: "Sr. Software Engineer",
  available: false,
  admin: false
)

franklin = User.create(
  email: "franklin@example.com",
  password: "12345",
  first_name: "Franklin",
  last_name: "Badu",
  company: "MonkeyGang Co,. Ltd.",
  job_title: "Jr. Software Engineer",
  available: false,
  admin: false
)

marcelo = User.create(
  email: "marcelo@example.com",
  password: "12345",
  first_name: "Marcelo",
  last_name: "Souza",
  job_title: "Sr. Software Engineer",
  company: "MonkeyGang Co,. Ltd.",
  available: false,
  admin: false
)

andrew = User.create(
  email: "andrew@example.com",
  password: "12345",
  first_name: "Andrew",
  last_name: "Cataluna",
  job_title: "Data Analist",
  company: "MonkeyGang Co,. Ltd.",
  available: false,
  admin: false
)

daniel = User.create(
  email: "daniel@example.com",
  password: "12345",
  first_name: "Daniel",
  last_name: "Costa",
  job_title: "UX Designer",
  company: "MonkeyGang Co,. Ltd.",
  available: false,
  admin: false
)

john = User.create(
  email: "john@example.com",
  password: "12345",
  first_name: "John",
  last_name: "Kesviwich",
  job_title: "UI Designer",
  company: "MonkeyGang Co,. Ltd.",
  available: false,
  admin: false
)

will = User.create(
  email: "will@example.com",
  password: "12345",
  first_name: "William",
  last_name: "Scott",
  job_title: "UX Designer",
  company: "MonkeyGang Co,. Ltd.",
  available: false,
  admin: false
)

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

ALLOW_USERS = User.all.find_all do |user|
  user.email != 'will@example.com' && user.email != 'john@example.com' && user.email != "admin@example.com"
end

def random_users 
  user_collection = []
  ALLOW_USERS.each do |u|
    [*0..1].sample == 1 ? user_collection << u : nil
  end
  return user_collection
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

# random_users().each do |user|
#   checkProjectCount(user, project_4)
# end

# random_users().each do |user|
#   checkProjectCount(user, project_5)
# end

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
  if user.projects.count < 3 &&
    toggle_user = User.find_by(id: user.id)
    toggle_user.update(available: true)
  end
end

# puts "#{random_users().count}"
# puts "#{ProjectTree.count} associations created for ProjectTree"
# puts "#{allow_users}"
# puts "#{User.all}"

puts "============================"
puts "          SEEDED"
puts "============================"