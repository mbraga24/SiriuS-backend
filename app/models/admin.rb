class Admin < ApplicationRecord
  has_secure_password
  has_many :projects

  def users 
    projects = self.projects
    total = []
    projects.map do |pj|
      pj.users.map do |us|
        total << us.email
      end
    end
    return total.uniq
  end

  # def project 
  #   projects = self.projects.map { |project| project.name }
  # end
end



# projects = Admin.first.projects
# total = 0 
# projects.each do |p|
#   total += p.users.count
# end