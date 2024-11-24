class AddDetailsToArts < ActiveRecord::Migration[7.1]
  def change
    add_column :arts, :name_of_place, :string
    add_column :arts, :address, :string
    add_column :arts, :email, :string
    add_column :arts, :phone_number, :string
    add_column :arts, :notes, :text
  end
end

