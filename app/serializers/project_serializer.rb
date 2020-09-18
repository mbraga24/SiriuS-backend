class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_date, :due_date, :done
  has_many :users
end
