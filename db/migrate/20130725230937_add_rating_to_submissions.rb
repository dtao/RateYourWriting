class AddRatingToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :rating, :decimal, :default => 0, :precision => 4, :scale => 2
  end
end
