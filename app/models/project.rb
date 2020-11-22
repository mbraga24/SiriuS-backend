class Project < ApplicationRecord
  has_many :documents, dependent: :delete_all
  has_many :project_trees, dependent: :delete_all
  has_many :users, through: :project_trees

  validates :name, presence: true, length: {maximum: 100}
  validates :description, presence: true, length: {maximum: 2000}
  validates :start_date, presence: true
  validates :due_date, presence: true
end
