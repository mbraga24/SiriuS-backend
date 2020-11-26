class User < ApplicationRecord
    has_secure_password

    has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'

    has_many :documents, dependent: :delete_all    
    has_many :archive_document, dependent: :delete_all

    has_many :project_trees, dependent: :delete_all
    has_many :projects, through: :project_trees

    has_many :archive_trees, dependent: :delete_all
    has_many :archive_projects, through: :arquive_trees
  
    before_save { self.email = email.downcase }
    VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :first_name, presence: true, length: {minimum: 2, maximum: 50}
    validates :last_name, presence: true, length: {minimum: 2, maximum: 50}
  
    validates :email,
              presence: true,
              length: { maximum: 25 },
              uniqueness: { case_sensitive: false },
              format: { with: VALID_EMAIL_FORMAT }
                
              
    validates :job_title,
              presence: true,
              length: { minimum: 6, maximum: 255 }
              
    validate :password_cant_be_blank, :if => :password          
    validate :password_lower_case, :if => :password
    validate :password_uppercase, :if => :password
    validate :password_special_char, :if => :password
    validate :password_contains_number, :if => :password            
    validates :password, length: { minimum: 6, maximum: 255 }, :if => :password

    # , :if => :password_digest_changed?
  
    def password_cant_be_blank
      if !!password.present? && password.blank? 
        return errors.add :password, "can't be blank "
      end
    end

    def password_lower_case
      return if !password.blank? && !!password.match(/\p{Lower}/)
      errors.add :password, ' must contain at least 1 uppercase '
    end
  
    def password_uppercase
      return if !password.blank? && !!password.match(/\p{Upper}/)
      errors.add :password, ' must contain at least 1 lowercase '
    end
  
    def password_special_char
      special = "?<>',?[]}{=-)(*&^%$#`~{}!"
      regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
      return if !password.blank? && password =~ regex
      errors.add :password, ' must contain special character'
    end
  
    def password_contains_number
      return if !password.blank? && password.count("0-9") > 0
      errors.add :password, ' must contain at least one number'
    end
  end
  