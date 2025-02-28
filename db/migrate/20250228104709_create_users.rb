class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :api_token, null: false
      t.timestamps
    end

    # add index token
    add_index :users, [:api_token], name: 'index_api_token'
  end
end
