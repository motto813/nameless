class AddInterviewIdToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :interview_id, :integer
  end
end
