class CreateSleeps < ActiveRecord::Migration[6.1]
  def change
    create_table :sleeps do |t|
      t.string :start_at
      t.string :end_at
      t.references :baby
    end
  end
end
