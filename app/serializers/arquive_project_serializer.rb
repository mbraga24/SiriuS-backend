class ArquiveProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_date, :due_date, :finish_date
  has_many :users
end
