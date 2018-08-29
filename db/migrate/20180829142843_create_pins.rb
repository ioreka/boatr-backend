class CreatePins < ActiveRecord::Migration[5.2]
  def change
    create_table :pins do |t|
      t.integer :user_id
      t.float :lat
      t.float :long
      t.string :comment

      t.timestamps
    end
  end
end
