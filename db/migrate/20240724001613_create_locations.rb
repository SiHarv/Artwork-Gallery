class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name_of_place
      t.string :address
      t.string :email
      t.string :phone_number
      t.text :notes

      t.timestamps
    end
  end
end
