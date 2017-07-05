class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :resume_id, null: false
      t.integer :position_id, null: false

      t.timestamps
    end
  end
end
