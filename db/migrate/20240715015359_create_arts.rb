class CreateArts < ActiveRecord::Migration[7.1]
  def change
    create_table :arts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
