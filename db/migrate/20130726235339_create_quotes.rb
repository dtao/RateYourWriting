class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :user_id
      t.string  :content
      t.string  :source
      t.timestamps
    end
  end
end
