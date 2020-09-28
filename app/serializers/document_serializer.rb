class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :user, :project
end