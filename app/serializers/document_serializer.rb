class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :project_id
end