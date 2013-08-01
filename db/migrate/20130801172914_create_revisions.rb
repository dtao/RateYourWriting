class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.integer :submission_id
      t.string  :kind
      t.string  :title
      t.text    :body
      t.timestamps
    end

    add_index :revisions, :submission_id
  end
end
