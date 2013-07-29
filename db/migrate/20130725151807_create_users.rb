class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email
      t.string  :password_digest
      t.boolean :admin, :default => false
      t.timestamps

      # Cached computations
      t.integer  :submissions_count, :default => 0
      t.decimal  :average_rating, :default => 0, :precision => 4, :scale => 2
      t.datetime :last_login

      # One-time verification
      t.boolean :email_verified, :default => false
    end

    add_index :users, :email, :unique => true
    add_index :users, :admin
  end
end
