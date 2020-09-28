class Project < ApplicationRecord
  has_many :documents, dependent: :delete_all
  has_many :project_trees, dependent: :delete_all
  has_many :users, through: :project_trees
end
