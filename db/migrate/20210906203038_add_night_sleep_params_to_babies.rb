class AddNightSleepParamsToBabies < ActiveRecord::Migration[6.1]
  def change
    add_column :babies, :night_sleep_start, :integer
    add_column :babies, :night_sleep_finish, :integer
  end
end
