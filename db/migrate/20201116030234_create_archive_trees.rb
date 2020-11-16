class CreateArchiveTrees < ActiveRecord::Migration[6.0]
  def change
    create_table :archive_trees do |t|
      t.references :user, null: false, foreign_key: true
      t.references :archive_project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
