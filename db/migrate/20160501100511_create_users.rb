class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :telegram_id

      t.timestamps
    end
    add_index :users, :telegram_id, unique: true
  end
end
