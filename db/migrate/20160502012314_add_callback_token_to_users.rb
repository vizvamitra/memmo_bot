class AddCallbackTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :callback_token, :string
  end
end
