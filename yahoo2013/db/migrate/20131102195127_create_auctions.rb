class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.string :link
      t.string :guid
      t.string :img
      t.string :price
      t.integer :user_id

      t.timestamps
    end
  end
end
