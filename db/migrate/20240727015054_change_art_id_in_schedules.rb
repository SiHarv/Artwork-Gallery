class ChangeArtIdInSchedules < ActiveRecord::Migration[6.0]
  def change
    # First, add the column if it does not exist
    unless column_exists?(:schedules, :art_id)
      add_column :schedules, :art_id, :integer
    end

    # Then, ensure the column is not null by first updating existing records
    change_column_null :schedules, :art_id, true # Temporarily allow null

    # Update existing records with a default value if necessary, or handle this in the application logic

    # Finally, set the column as not null
    change_column_null :schedules, :art_id, false

    # Add foreign key constraint
    add_foreign_key :schedules, :arts
  end
end
