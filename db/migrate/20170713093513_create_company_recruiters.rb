class CreateCompanyRecruiters < ActiveRecord::Migration
  def change
    create_table :company_recruiters do |t|
      t.integer :company_id, null: false
      t.integer :recruiter_id, null: false

      t.timestamps
    end
  end
end
