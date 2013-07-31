class AddImageUrlToUserPreferences < ActiveRecord::Migration
  def change
    add_column :user_preferences, :image_url, :string
  end
end
