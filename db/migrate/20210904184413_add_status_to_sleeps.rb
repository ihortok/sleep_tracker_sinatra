class AddStatusToSleeps < ActiveRecord::Migration[6.1]
  def change
    add_column :sleeps, :status, :integer
  end
end
