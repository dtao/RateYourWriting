class CreateUserPreferences < ActiveRecord::Migration
  def change
    create_table :user_preferences do |t|
      t.integer :user_id
      t.string  :theme
      t.timestamps
    end

    add_index :user_preferences, :user_id
  end
end
