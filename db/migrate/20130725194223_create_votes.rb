class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :submission_id
      t.integer :rating
    end

    add_index :votes, :submission_id
  end
end
