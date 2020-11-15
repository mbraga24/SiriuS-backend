class ArquiveProject < ApplicationRecord
  has_many :arquive_trees, dependent: :delete_all
  has_many :users, through: :arquive_trees
end
