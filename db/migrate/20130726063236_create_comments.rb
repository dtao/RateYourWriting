class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :submission_id
      t.text    :content
      t.timestamps
    end

    add_index :comments, :submission_id
  end
end
