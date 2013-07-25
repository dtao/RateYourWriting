class AddVotesCounterCacheToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :votes_count, :integer, :default => 0
  end
end
