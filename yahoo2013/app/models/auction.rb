class Auction < ActiveRecord::Base
  belongs_to :user
  before_save :default_value

  private 
    def default_value
      self.is_post = false if self.is_post.nil?
      true
    end
end
