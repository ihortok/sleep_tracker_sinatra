class CreateBabyParams < ActiveRecord::Migration[6.1]
  def change
    create_table :baby_params do |t|
      t.integer :weight
      t.integer :height
      t.datetime :measurement_date
      t.references :baby
    end
  end
end
