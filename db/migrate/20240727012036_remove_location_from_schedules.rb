class RemoveLocationFromSchedules < ActiveRecord::Migration[7.1]
  def change
    remove_column :schedules, :location, :string
  end
end
