class CreateSleeps < ActiveRecord::Migration[6.1]
  def change
    create_table :sleeps do |t|
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :status
      t.references :baby

      t.timestamps
    end
  end
end
