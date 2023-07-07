class CreateVehicle < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.integer :model_year
      t.string :make
      t.string :model
      t.integer :mileage
      t.boolean :repairs_needed
      t.integer :seating
      t.date :last_service_date
      t.integer :engine_hours

      t.timestamps
    end
  end
end
