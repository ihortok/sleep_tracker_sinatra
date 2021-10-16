class CreateBabyParams < ActiveRecord::Migration[6.1]
  def change
    create_table :baby_params do |t|
      t.integer :weight
      t.integer :height
      t.date :date_of_measurement
      t.references :baby

      t.timestamps
    end
  end
end
