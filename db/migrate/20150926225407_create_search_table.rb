class CreateSearchTable < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.references :user, index: true, foreign_key: true
      t.string :query
      t.integer :count, :default => 0
    end
  end
end
