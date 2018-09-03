class CreateMarkers < ActiveRecord::Migration[5.2]
  def change
    create_table :markers do |t|
      t.integer :user_id
      t.float :lat
      t.float :lng
      t.string :comment

      t.timestamps
    end
  end
end
