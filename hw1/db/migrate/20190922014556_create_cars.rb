class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.references :make, foreign_key: true
      t.string :model
      t.string :vin

      t.timestamps
    end
  end
end
