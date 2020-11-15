class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :created_at
  belongs_to :user
  belongs_to :project
end