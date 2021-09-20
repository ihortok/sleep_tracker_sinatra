class CreateBabyParams < ActiveRecord::Migration[6.1]
  def change
    create_table :baby_params do |t|
      t.integer :weight
      t.integer :height
      t.datetime :measurement_date
      t.references :baby

      t.datetime :created_at, precision: 6, null: false
    end
  end
end
