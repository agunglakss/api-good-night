class CreateSleepTrackings < ActiveRecord::Migration[7.1]
  def change
    create_table :sleep_trackings do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.datetime :clock_in, null: false
      t.datetime :clock_out
      t.integer  :duration # in second
      t.timestamps
    end

    # indexing field user_id and clock_in
    add_index :sleep_trackings, [:user_id, :clock_in], name: 'index_tracking_logs_on_user_id_and_clock_in'
  end
end
