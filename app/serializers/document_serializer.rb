class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :created_at
  belongs_to :user
  belongs_to :project

  # def to_json
  #   super.merge('created_at' => self.created_at.strftime("%d %b %Y"))
  # end
end