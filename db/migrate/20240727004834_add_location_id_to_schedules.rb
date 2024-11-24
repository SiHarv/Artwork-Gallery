class AddLocationIdToSchedules < ActiveRecord::Migration[7.1]
  def change
    add_column :schedules, :location_id, :integer
  end
end
