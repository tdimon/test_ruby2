class CreateApiSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :api_settings do |t|
      t.string :account, null: false
      t.string :token, null: false
    end
  end
end
