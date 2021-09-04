class CreateSleeps < ActiveRecord::Migration[6.1]
  def change
    create_table :sleeps do |t|
      t.string :started_at
      t.string :finished_at
      t.references :baby
    end
  end
end
