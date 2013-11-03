class User < ActiveRecord::Base
  #attr_accessible :fb_id, :fb_name, :fb_access_token, :fb_picture, :y_auction_id, :y_oauth_token, :y_oauth_verifier, :fb_page_access_token 
  has_many :auctions

  def self.get_user_from_fb_access_token(current_user, access_token)
    return nil unless access_token

    @graph = Koala::Facebook::API.new(access_token)
    # get user information
    @me = @graph.get_object("me")
    @picture = @graph.get_picture(@me["id"])

    # check permissions
    @permissions = @graph.get_connections("me", "permissions")[0]
    #PERMISSIONS.each { |p| raise Exceptions::AccessTokenNotFound unless @permissions[p] == 1 }

    # find user
    @user = current_user if current_user 
    @user = find_by(:fb_id => @me["id"]) unless current_user
    if @user
      @user.update_attributes!(fb_id: @me["id"], fb_name: @me["name"], fb_picture: @picture, fb_access_token: access_token)
    else
      @user = self.new(fb_id: @me["id"], fb_name: @me["name"], fb_picture: @picture, fb_access_token: access_token)
      @user.save!
    end

    return @user
  end

  def self.get_user_from_y_token_and_verifier(current_user, token, verifier, auction_id)
    @user = current_user if current_user
    @user = find_by(:y_auction_id => auction_id) unless current_user
    if @user 
      @user.update_attributes!(:y_oauth_token => token, :y_oauth_verifier => verifier, :y_auction_id => auction_id)
    else
      @user = self.new(y_oauth_token: token, y_oauth_verifier: verifier, y_auction_id: auction_id)
      @user.save!
    end

    return @user
  end

  def get_page_access_token
    graph = fb_graph

    fan_page = graph.get_object(self.fb_fan_page)
    current_user.update_attributes!(fb_fan_page: fan_page["id"])

    page_accounts = graph.get_connections('me', 'accounts')
    page_accounts.each do |account|
      if account["id"] == fan_page["id"]
        self.update_attributes!(fb_page_access_token: account["access_token"])
      end
    end
  end

  def fb_graph
    Koala::Facebook::API.new(self.fb_access_token)
  end

  def fb_page_graph
    get_page_access_token
    Koala::Facebook::API.new(self.fb_page_access_token)
  end

  def is_fb_access_token_valid?
    me = fb_graph.get_object("me")
    true
  rescue
    false
  end
end
