class AdminSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :company, :job_title, :users, :projects
end
