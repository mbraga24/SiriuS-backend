class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :company
      t.string :job_title
      t.timestamps
    end
  end
end
