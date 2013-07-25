class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.string  :title
      t.text    :body
      t.timestamps
    end

    add_index :submissions, :user_id
  end
end
