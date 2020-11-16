class CreateArchiveDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :archive_documents do |t|
      t.string :name
      t.string :url
      t.references :user, null: false, foreign_key: true
      t.references :archive_project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
