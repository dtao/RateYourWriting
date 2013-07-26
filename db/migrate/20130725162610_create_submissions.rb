class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.string  :kind
      t.string  :title
      t.text    :body
      t.timestamps

      # Cached computations
      t.integer :length
      t.integer :votes_count, :default => 0
      t.decimal :rating, :precision => 4, :scale => 2, :default => 0
    end

    add_index :submissions, :user_id
  end
end
