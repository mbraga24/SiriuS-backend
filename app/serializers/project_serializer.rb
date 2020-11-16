class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_date, :due_date
  has_many :users
end
