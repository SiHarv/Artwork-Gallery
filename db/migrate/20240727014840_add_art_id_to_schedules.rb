class AddArtIdToSchedules < ActiveRecord::Migration[7.1]
  def change
    add_column :schedules, :art, :integer
  end
end
