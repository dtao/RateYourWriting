class AddPublishedToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :published, :boolean, :default => false
    add_index :submissions, :published
  end
end
