class User < ApplicationRecord
    has_secure_password
    
    has_many :documents, dependent: :delete_all    
    has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'

    has_many :project_trees, dependent: :delete_all
    has_many :projects, through: :project_trees

    has_many :archive_trees, dependent: :delete_all
    has_many :archive_projects, through: :arquive_trees
  
    before_save { self.email = email.downcase }
    VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :first_name, presence: true, length: {maximum: 50}
    validates :last_name, presence: true, length: {maximum: 50}
  
    validates :email,
              presence: true,
              length: { maximum: 25 },
              uniqueness: { case_sensitive: false },
              format: { with: VALID_EMAIL_FORMAT }
                
    validates :password,
              presence: true, # <= does not work with custom validations - read more at the bottom
              length: { minimum: 6, maximum: 255 }

    validates :job_title,
              presence: true,
              length: { minimum: 6, maximum: 255 }
  
    # validate :password_lower_case
    # validate :password_uppercase
    # validate :password_special_char
    # validate :password_contains_number            
  
    # def password_lower_case
    #   return if !!password.match(/\p{Lower}/)
    #   errors.add :password, ' must contain at least 1 lowercase '
    # end
  
    # def password_uppercase
    #   return if !!password.match(/\p{Upper}/)
    #   errors.add :password, ' must contain at least 1 uppercase '
    # end
  
    # def password_special_char
    #   special = "?<>',?[]}{=-)(*&^%$#`~{}!"
    #   regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
    #   return if password =~ regex
    #   errors.add :password, ' must contain special character'
    # end
  
    # def password_contains_number
    #   return if password.count("0-9") > 0
    #   errors.add :password, ' must contain at least one number'
    # end
  
    # All custom validations work with or without ":password presence: true". 
    # Unfortunately the "presence: true" validations does not work when the 
    # password field is blank and submitted. 
  end
  