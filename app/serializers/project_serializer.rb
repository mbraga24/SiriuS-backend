class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_date, :due_date, :done, :finish_date
  has_many :users
end
