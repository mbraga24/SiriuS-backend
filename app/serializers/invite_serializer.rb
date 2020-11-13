class InviteSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :sender_id
end
