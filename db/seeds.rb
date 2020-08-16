User.destroy_all
Project.destroy_all
Admin.destroy_all
ProjectTree.destroy_all

admin_1 = Admin.create(
  email: "admin@example.com",
  first_name: "marlon",
  last_name: "braga",
  password: "12345",
  company: "MonkeyGang Co,. Ltd.",
  job_title: "Project Manager"
)

project_1 = Project.create(
  name: "MonkeyGang website",
  description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloremque, est.",
  start_date: "",
  due_date: "",
  admin: admin_1
)

project_2 = Project.create(
  name: "MonkeyGang mobile app",
  description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloremque, est.",
  start_date: "",
  due_date: "",
  admin: admin_1
)

marlon = User.create(
  email: "mark@example",
  password: "12345",
  first_name: "mark",
  last_name: "koslo",
  job_title: "sr. software engineer"
)

franklin = User.create(
  email: "franklin@example",
  password: "12345",
  first_name: "franklin",
  last_name: "badu",
  job_title: "jr. software engineer"
)

marcelo = User.create(
  email: "marcelo@example",
  password: "12345",
  first_name: "marcelo",
  last_name: "souza",
  job_title: "senior software engineer"
)

andrew = User.create(
  email: "andrew@example",
  password: "12345",
  first_name: "andrew",
  last_name: "cataluna",
  job_title: "data analist"
)

ale = User.create(
  email: "alexandra@example",
  password: "12345",
  first_name: "alexandra",
  last_name: "koslo",
  job_title: "UX designer"
)

User.all.each do |user|
  ProjectTree.create(
    user: user,
    project: project_1
  )
end

puts "============================"
puts "          SEEDED"
puts "============================"