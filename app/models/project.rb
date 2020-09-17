class Project < ApplicationRecord
  has_many :project_trees
  has_many :users, through: :project_trees
end
