class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :company, :job_title, :available, :sent_invites, :admin
  has_many :projects
end
