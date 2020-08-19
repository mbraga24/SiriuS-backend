ProjectTree.destroy_all
Project.destroy_all
Admin.destroy_all
User.destroy_all

admin_1 = Admin.create(
  email: "admin@example.com",
  first_name: "Marlon",
  last_name: "Braga",
  password: "12345",
  company: "MonkeyGang Co,. Ltd.",
  job_title: "Project Manager"
)

project_1 = Project.create(
  name: "Riviera SaaS website",
  description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloremque, est.",
  start_date: "August 8th - 2020",
  due_date: "December 5th - 2020",
  admin: admin_1
)

project_2 = Project.create(
  name: "Riviera SaaS mobile app",
  description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloremque, est.",
  start_date: "August 8th - 2020",
  due_date: "December 8th - 2020",
  admin: admin_1
)

project_3 = Project.create(
  name: "Riviera SaaS Marketing Strategy",
  description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloremque, est.",
  start_date: "August 8th - 2020",
  due_date: "December 8th - 2020",
  admin: admin_1
)

mark = User.create(
  email: "mark@example",
  password: "12345",
  first_name: "Mark",
  last_name: "Koslo",
  job_title: "Sr. Software Engineer",
  available: false
)

franklin = User.create(
  email: "franklin@example",
  password: "12345",
  first_name: "Franklin",
  last_name: "Badu",
  job_title: "Jr. Software Engineer",
  available: false
)

marcelo = User.create(
  email: "marcelo@example",
  password: "12345",
  first_name: "Marcelo",
  last_name: "Souza",
  job_title: "Sr. Software Engineer",
  available: false
)

andrew = User.create(
  email: "andrew@example",
  password: "12345",
  first_name: "Andrew",
  last_name: "Cataluna",
  job_title: "Data Analist",
  available: false
)

daniel = User.create(
  email: "daniel@example",
  password: "12345",
  first_name: "Daniel",
  last_name: "Costa",
  job_title: "UX Designer",
  available: false
)

john = User.create(
  email: "john@example",
  password: "12345",
  first_name: "John",
  last_name: "Kesviwich",
  job_title: "UI Designer",
  available: false
)

will = User.create(
  email: "will@example",
  password: "12345",
  first_name: "William",
  last_name: "Scott",
  job_title: "UX Designer",
  available: false
)

ALLOW_USERS = User.all.find_all do |user|
  user.email != 'will@example' && user.email != 'john@example'
end

def random_users 
  user_collection = []
  ALLOW_USERS.each do |u|
    [*0..1].sample == 1 ? user_collection << u : nil
  end
  return user_collection
end

random_users().each do |user|
  ProjectTree.create(
    user: user,
    project: project_1
  )
end

random_users().each do |user|
  ProjectTree.create(
    user: user,
    project: project_2
  )
end

random_users().each do |user|
  ProjectTree.create(
    user: user,
    project: project_3
  )
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
  if user.projects.count < 3 
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