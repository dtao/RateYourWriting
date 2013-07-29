class AddPreviousLoginToUser < ActiveRecord::Migration
  def change
    add_column :users, :previous_login, :datetime
  end
end
