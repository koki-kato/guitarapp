class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false

      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
