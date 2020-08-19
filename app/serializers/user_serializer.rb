class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :job_title, :available
  has_many :projects
end
