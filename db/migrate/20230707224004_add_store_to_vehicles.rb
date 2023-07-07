class AddStoreToVehicles < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :store, null: false, foreign_key: true
  end
end
