class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :bio
      t.string :login_token
      t.datetime :login_token_valid_until

      t.timestamps
    end
  end
end
