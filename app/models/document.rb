class Document < ApplicationRecord
  # mount_uploader :url, FileUploader
  belongs_to :project
  belongs_to :user

  # format created_at column 
  def created_at
    attributes['created_at'].strftime("%m/%d/%Y")
    # ("%m/%d/%Y %H:%M")
  end
end
