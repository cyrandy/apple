class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fb_id
      t.string :fb_name
      t.text :fb_access_token
      t.string :y_auction_id
      t.string :y_oauth_token
      t.string :y_oauth_verifier

      t.timestamps
    end
  end
end
