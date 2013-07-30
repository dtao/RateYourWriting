class CreateSingleUseNotices < ActiveRecord::Migration
  def change
    create_table :single_use_notices do |t|
      t.integer :user_id
      t.string  :token
      t.string  :type
      t.string  :message
      t.timestamps
    end

    add_index :single_use_notices, :user_id
  end
end
