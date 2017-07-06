class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :title, null: false
      t.string :description, null: false

      t.integer :company_id, null: false
      t.integer :recruiter_id, null: false

      t.timestamps
    end
  end
end
