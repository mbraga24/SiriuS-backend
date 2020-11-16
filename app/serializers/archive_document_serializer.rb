class ArchiveDocumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :url
  belongs_to :user
  belongs_to :archive_project
end
