class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.datetime :meeting_time, null: false

      t.integer :application_id, null: false
      t.integer :applicant_id, null: false
      t.integer :recruiter_id, null: false

      t.timestamps
    end
  end
end
