class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :pdf, :project_id
end