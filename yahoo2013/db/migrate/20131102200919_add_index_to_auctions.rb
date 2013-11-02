class AddIndexToAuctions < ActiveRecord::Migration
  def change
    add_index :auctions, :guid
  end
end
