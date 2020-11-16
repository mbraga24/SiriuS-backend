class CreateArchiveProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :archive_projects do |t|
      t.string :name
      t.string :description
      t.string :start_date
      t.string :due_date
      t.string :archived_date

      t.timestamps
    end
  end
end
