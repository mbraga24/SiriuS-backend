class ArchiveDocumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :user, :archive_project
end
