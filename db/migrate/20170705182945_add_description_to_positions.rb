class AddDescriptionToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :description, :string
  end
end
