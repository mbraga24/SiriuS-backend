class ArchiveProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_date, :due_date, :archived_date
  has_many :users
  has_many :archive_documents
end
