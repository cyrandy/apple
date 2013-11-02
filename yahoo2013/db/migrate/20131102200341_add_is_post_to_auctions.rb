class AddIsPostToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :is_post, :boolean
  end
end
