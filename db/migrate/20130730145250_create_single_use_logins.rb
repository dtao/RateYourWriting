class CreateSingleUseLogins < ActiveRecord::Migration
  def change
    create_table :single_use_logins do |t|
      t.integer :user_id
      t.string  :token
      t.timestamps
    end

    add_index :single_use_logins, :token
  end
end
