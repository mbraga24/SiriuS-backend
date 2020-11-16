class ArchiveProject < ApplicationRecord
  has_many :archive_documents, dependent: :delete_all
  has_many :archive_trees, dependent: :delete_all
  has_many :users, through: :archive_trees
end
