class AddDoneToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :done, :boolean, default: false
  end
end
