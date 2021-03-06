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
      t.integer :comments_count, :default => 0
      t.decimal :rating, :precision => 4, :scale => 2, :default => 0
      t.datetime :last_vote
      t.datetime :last_comment
    end

    add_index :submissions, :user_id
    add_index :submissions, :kind
  end
end
