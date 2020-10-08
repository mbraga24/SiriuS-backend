class User < ApplicationRecord
  has_secure_password
  has_many :documents
  has_many :project_trees, dependent: :delete_all
  has_many :projects, through: :project_trees

  before_save { self.email = email.downcase }
  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
            presence: true,
            length: { maximum: 25 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_FORMAT }

  validates :password,
            presence: true,
            length: { minimum: 6, maximum: 255 }

  validate :password_lower_case
  validate :password_uppercase
  validate :password_special_char
  validate :password_contains_number

  private

  def password_lower_case
    return if !!password.match(/\p{Lower}/)
    errors.add :password, ' must contain at least 1 lowercase '
  end

  def password_uppercase
    return if !!password.match(/\p{Upper}/)
    errors.add :password, ' must contain at least 1 uppercase '
  end

  def password_special_char
    special = "?<>',?[]}{=-)(*&^%$#`~{}!"
    regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
    return if password =~ regex
    errors.add :password, ' must contain special character'
  end

  def password_contains_number
    return if password.count("0-9") > 0
    errors.add :password, ' must contain at least one number'
  end
end
