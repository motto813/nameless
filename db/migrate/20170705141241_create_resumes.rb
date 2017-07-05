class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :file_location, null: false

      t.integer :applicant_id, null: false

      t.timestamps
    end
  end
end
