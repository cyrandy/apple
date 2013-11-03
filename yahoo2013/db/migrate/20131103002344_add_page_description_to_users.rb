class AddPageDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :page_description, :text
    add_column :users, :fb_fan_page, :string
  end
end
