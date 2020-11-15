class Invite < ApplicationRecord
  before_create :generate_token
  belongs_to :sender, :class_name => 'User'

  before_save { self.email = email.downcase }
  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}

  validates :email,
            presence: true,
            length: { maximum: 45 },
            format: { with: VALID_EMAIL_FORMAT }

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.id, Time.now, rand].join)
  end
end
