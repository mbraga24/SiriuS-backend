class User < ApplicationRecord
  has_secure_password
  has_many :project_trees
  has_many :projects, through: :project_trees

  # def assigned
  #   return self.projects.map do |project|
  #     project ? project : null
  #   end
  # end
end
