class CreateBabies < ActiveRecord::Migration[6.1]
  def change
    create_table :babies do |t|
      t.string :name
      t.string :gender
      t.datetime :date_of_birth
      t.references :user
    end
  end
end
