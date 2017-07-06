class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :file_name, null: false
      t.string :file_path, null: false

      t.integer :applicant_id, null: false

      t.timestamps
    end
  end
end
