class AddFbPageAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_page_access_token, :text
  end
end
