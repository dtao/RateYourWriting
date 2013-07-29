class CreateVerificationTokens < ActiveRecord::Migration
  def change
    create_table :verification_tokens do |t|
      t.integer :user_id
      t.string  :token
    end
  end
end
