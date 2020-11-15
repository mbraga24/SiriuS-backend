class CreateArquiveProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :arquive_projects do |t|
      t.string :name
      t.string :description
      t.string :start_date
      t.string :due_date
      t.string :finish_date
      t.boolean :arquived, default: true

      t.timestamps
    end
  end
end
