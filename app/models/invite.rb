class Invite < ApplicationRecord
  before_create :generate_token
  # belongs_to :user
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User', optional: true

  def generate_token
    # byebug
    self.token = Digest::SHA1.hexdigest([self.id * 666, Time.now, rand].join)
  end
end
