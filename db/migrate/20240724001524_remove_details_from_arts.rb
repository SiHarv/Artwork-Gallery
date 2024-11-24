class RemoveDetailsFromArts < ActiveRecord::Migration[7.1]
  def change
    remove_column :arts, :name_of_place, :string
    remove_column :arts, :address, :string
    remove_column :arts, :email, :string
    remove_column :arts, :phone_number, :string
    remove_column :arts, :notes, :text
  end
end
