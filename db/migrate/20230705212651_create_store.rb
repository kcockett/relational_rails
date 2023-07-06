class CreateStore < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :store_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zip_code
      t.boolean :currently_hiring

      t.string :manager_name

      t.timestamps
    end
  end
end
