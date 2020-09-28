class User < ApplicationRecord
  has_secure_password
  has_many :documents
  has_many :project_trees, dependent: :delete_all
  has_many :projects, through: :project_trees
end
