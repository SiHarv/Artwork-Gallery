class RemoveArtFromSchedules < ActiveRecord::Migration[6.0]
  def change
    remove_column :schedules, :art, :integer
  end
end
