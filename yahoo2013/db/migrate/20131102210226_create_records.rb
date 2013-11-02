class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :link
      t.string :guid
      t.string :auction_id

      t.timestamps
    end
  end
end
