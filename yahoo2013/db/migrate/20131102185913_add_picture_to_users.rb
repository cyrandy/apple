class AddPictureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_picture, :string
  end
end
