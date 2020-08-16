class AdminSerializer < ActiveModel::Serializer
  attributes :id, :email, :company, :job_title
end
