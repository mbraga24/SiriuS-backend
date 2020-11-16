class ArchiveTree < ApplicationRecord
  belongs_to :user
  belongs_to :archive_project
end
