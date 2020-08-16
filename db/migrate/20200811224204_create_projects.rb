class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :start_date
      t.string :due_date
      t.references :admin, null: false, foreign_key: true
      t.timestamps
    end
  end
end
