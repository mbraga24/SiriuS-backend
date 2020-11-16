class ArchiveDocument < ApplicationRecord
  belongs_to :user
  belongs_to :archive_project
end
