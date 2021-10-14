class CreateFeedings < ActiveRecord::Migration[6.1]
  def change
    create_table :feedings do |t|
      t.datetime :started_at
      t.datetime :finished_at
      t.references :baby
      t.integer :status
      t.string :breast

      t.timestamps
    end
  end
end
