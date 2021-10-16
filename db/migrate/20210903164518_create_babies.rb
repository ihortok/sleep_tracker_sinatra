class CreateBabies < ActiveRecord::Migration[6.1]
  def change
    create_table :babies do |t|
      t.string :name
      t.string :gender
      t.datetime :date_of_birth
      t.integer :falling_asleep_hour
      t.integer :wakening_hour
      t.references :user

      t.timestamps
    end
  end
end
