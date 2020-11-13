class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :company, :job_title, :available, :admin
  has_many :projects
  has_many :sent_invites
end
