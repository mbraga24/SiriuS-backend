class User < ApplicationRecord
  has_secure_password
  has_many :project_trees
  has_many :projects, through: :project_trees
end
