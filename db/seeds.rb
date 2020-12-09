ProjectTree.destroy_all
ArchiveTree.destroy_all
ArchiveDocument.destroy_all
Project.destroy_all
ArchiveProject.destroy_all
Document.destroy_all
User.destroy_all

# ========================================================================
#                             CREATE PROJECTS
# ========================================================================

project_1 = Project.create(
  name: "Rivver website",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding stand-up meetings every morning at 10:30am sharp. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me at any time of the day: (333)-444-9009",
  start_date: "08/25/2020",
  due_date: "09/20/2020"
)

project_2 = Project.create(
  name: "Rivver mobile app",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding stand-up meetings every morning at 10:30am sharp. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me at any time of the day: (333)-444-9009",
  start_date: "08/27/2020",
  due_date: "09/20/2020"
)

project_3 = Project.create(
  name: "Rivver Website Menu",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding stand-up meetings every morning at 10:30am sharp. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me at any time of the day: (333)-444-9009",
  start_date: "08/21/2020",
  due_date: "09/20/2020"
)

# ========================================================================
#                             CREATE USERS
# ========================================================================

marlon = User.create(
  email: "marlon@example.com",
  first_name: "Marlon",
  last_name: "Braga",
  company: "Design Monkey",
  job_title: "Project Manager",
  available: true,
  admin: true,
  password: "1L*vesalami"
)

mark = User.create(
  email: "markk@example.com",
  first_name: "Mark",
  last_name: "Keathon",
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

marcela = User.create(
  email: "marcela@example.com",
  first_name: "Marcela",
  last_name: "Water",
  job_title: "Sr. Software Engineer",
  company: marlon.company,
  available: false,
  admin: false,
  password: "1L*vesalami"
)

andressa = User.create(
  email: "andressa@example.com",
  first_name: "Andressa",
  last_name: "Malta",
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

sarah = User.create(
  email: "sarah@example.com",
  first_name: "Sarah",
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
  (user.email != 'william@example.com') && (user.email != 'sarah@example.com') && (user.email != 'marlon@example.com') && (user.email != 'andressa@example.com')
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

# Time.now.strftime("%m/%d/%Y")

archived_project = ArchiveProject.create(
  name: "Rivver Menu Button",
  description: "This is a new account and a very important client. The team will be respossible for X and Y and we will be holding stand-up meetings every morning at 10:30am sharp. If we conclude this project on time there is a great chance we can close future projects with this client. Please don't hesitate to reach out to me at any time of the day: (333)-444-9009",
  start_date: "08/21/2020",
  due_date: "09/20/2020",
  archived_date: "11/13/2020"
)

ArchiveTree.create(
  user: User.second,
  archive_project: archived_project
)

ArchiveTree.create(
  user: User.third,
  archive_project: archived_project
)

ArchiveDocument.create(
  name: "Project Requirements",
  url: "https://res.cloudinary.com/dloh9txdc/image/upload/v1604597179/Project_Requirements_-_Demo_zwe3qu.pdf",
  user: User.third,
  archive_project: archived_project
)

# =============================================================================================
#           CUSTOM USER/PROJECT/DOCUMENT CREATION FOR TESTING >MARLON< AND >ANDREW<
# =============================================================================================

ProjectTree.create(
    user: andressa,
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
  user: andressa,
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

# =============================================================================================
#           SET ALL USERS WITH LEE
# =============================================================================================

User.all.each do |user| 
  if user.projects.count < 3
    toggle_user = User.find_by(id: user[:id]) 
    toggle_user.toggle!(:available)
  end
end

puts "#{User.all.count} users created"
puts "#{Project.all.count} projects created"
puts "#{ArchiveTree.all.count} (ArchiveTree) user's associations archived"
puts "#{ArchiveDocument.all.count} (ArchiveDocument) document's associations archived"
puts "#{ArchiveProject.all.count} (ArchiveProject) projects archived"
puts "#{ProjectTree.all.count} user->project (ProjectTree) created"
puts "#{Document.all.count} Documents created"

puts "============================"
puts "          SEEDED"
puts "============================"