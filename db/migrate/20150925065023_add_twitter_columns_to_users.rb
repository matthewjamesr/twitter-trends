class AddTwitterColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_token, :string
    add_column :users, :uid, :string
    add_column :users, :twitter_secret, :string
  end
end
