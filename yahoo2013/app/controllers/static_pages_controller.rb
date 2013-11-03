#encoding: utf-8
require 'xmlsimple'
class StaticPagesController < ApplicationController
  before_filter :allow_iframe_requests, :only => [:fbauth]
  protect_from_forgery except: :fbauth

  def getfans
    if params[:fb_fan_page]
      redirect_to :back if params[:fb_fan_page].empty?
      fb_fan_page = /.*com\/(.*)\?.*/.match(params[:fb_fan_page])
      current_user.update_attributes!(params[:fb_fan_page]) 
    end
    @fb_sign_in = fb_sign_in?
    @y_sign_in =  y_sign_in?
    @fb_login_page = get_permission_page
    
    render layout: false
  end

  def handle_fb_access_token
    fb_sign_in(User.get_user_from_fb_access_token(current_user, params[:authResponse][:accessToken])) if params[:authResponse][:accessToken]
  end

  def fbauth
    signed_request = params[:signed_request]
    
    if session[:graph].nil? || true
      redirect_to_fb_site and return if signed_request.nil? || signed_request.empty?

      # init
      @oauth = Koala::Facebook::OAuth.new(FB_APP_ID, FB_SECRET, "#{SITE_ROOT}/oauth/facebook/callback")
      @parsed_signed_request = @oauth.parse_signed_request(signed_request)
      @access_token = @parsed_signed_request["oauth_token"]

      redirect_to_permission_page and return if @access_token.nil?

      # get user data
      user = User.get_user_from_fb_access_token(current_user, @access_token)
      #user.get_page_access_token
      fb_sign_in(user)

      if session[:redirect_url]
        begin
          url = URI.escape session[:redirect_url]
          session.delete(:redirect_url)
          redirect_to url and return 
        rescue
          logger.info "error when redirect url"
        end
      end
    end

    render inline: top_location_redirect_script("/getfans") and return
  end

  def fbcallback
    @oauth = Koala::Facebook::OAuth.new(FB_APP_ID, FB_SECRET, "#{SITE_ROOT}/oauth/facebook/callback")
    access_token = @oauth.get_access_token(params[:code])
    
    user = User.get_user_from_fb_access_token(current_user, @access_token)
    user.get_page_access_token 
    fb_sign_in(user)
    
    render inline: top_location_redirect_script("/getfans") and return
    #redirect_to FB_APP_SITE
  end

  def close_window
    render layout: false
  end

  def fbpost
    redirect_url = URI.escape("/facebook/post?name=#{params[:name]}&link=#{params[:link]}&pic=#{params[:pic]}")

    if session[:graph].nil?
      session[:redirect_url] = redirect_url
      redirect_to_fb_site and return 
    end
    #session[:graph].put_wall_post("test123 #test", {:name => params[:name], :link => params[:link]}, "192419394248940")
    session[:graph].put_wall_post("test123 #test", {"name" => params[:name], "link" => params[:link], 
                                  "caption" => "test", "description" => "description", 
                                  "picture" => params[:pic]}, "192419394248940")

    #session[:graph].put_connections("192419394248940", "feed?message=foo%0D%0Abar&link=http://www.google.com.tw")

    render :nothing => true
  rescue 
    session[:redirect_url] = redirect_url
    redirect_to_fb_site and return
  end

  def yahooauth
    key = Y_KEY
    secret = Y_SECRET
    options = { 
       :access_token_path => '/oauth/v2/get_token',
       :authorize_path => '/oauth/v2/request_auth',
       :request_token_path => '/oauth/v2/get_request_token',
       :site => 'https://api.login.yahoo.com',
    }
     
    session[:consumer] = OAuth::Consumer.new key, secret, options
    session[:request_token] = session[:consumer].get_request_token(:oauth_callback => "#{SITE_ROOT}/oauth/yahoo/callback")
    logger.info session[:request_token].authorize_url

    redirect_to session[:request_token].authorize_url and return
  end

  def yahoocallback
    oauth_token = params[:oauth_token]
    oauth_verifier = params[:oauth_verifier]

    access_token = session[:request_token].get_access_token :oauth_verifier => oauth_verifier

    #yql = "SELECT * FROM social.profile WHERE guid=me"
    #yql = 'SELECT * FROM html WHERE url="http://tw.page.bid.yahoo.com/tw/auction/f54314511?u=Y2655018685"'
    #response = session[:consumer].request(:get, "http://query.yahooapis.com/v1/yql?q=#{URI.escape(yql)}&format=json", access_token)
    #logger.info response.body
    #File.open("kerker", "w") {|f| f.write response.body.force_encoding('utf-8')}

    response = session[:consumer].request(:get, "http://tw.bid.yahooapis.com/v1/ws/fetch/idmapping?format=json", access_token)
    logger.info response.body
    yahoo_auction_id = JSON.parse(response.body)['response']['result']['data']['auid']
    logger.info yahoo_auction_id

    user = User.get_user_from_y_token_and_verifier(current_user, oauth_token, oauth_verifier, yahoo_auction_id)
    y_sign_in(user) 

    render inline: top_location_redirect_script("/getfans") and return
  end

  def sync
    render :text => "Error" and return unless fb_sign_in? && y_sign_in?

    yahoo_auction_id = current_user.y_auction_id
    logger.info yahoo_auction_id
    url = "http://tw.user.bid.yahoo.com/tw/rss/booth/#{yahoo_auction_id}"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body

    data = XmlSimple.xml_in(xml_data)['channel']
    data[0].each do |item|
      if item[0] == "item"
        item[1].each do |real_item|
          title = real_item['title'][0]
          link = real_item['link'][0].sub('http://tw.rd.yahoo.com/referurl/bid/RSS/booth/*', '')
          guid = real_item['guid'][0]
          description = real_item['description'] # img
          img = /.*img.*src="(.*)" .*/.match(description[0])[1]
          price = /目前出價: <b>(.*)<\/b>/.match(description[0])[1]

          logger.info link
          page_content = Net::HTTP.get_response(URI.parse(link)).body.force_encoding('utf-8')
          logger.info page_content
          page_description = /.*name\=.description.*content=\'(.*)\'>/.match(page_content)[1]

          auction = current_user.auctions.find_by(guid: guid)
          if auction
            # todo
          else
            current_user.auctions.create!(title: title, link: link, guid: guid, img: img, price: price, description: page_description)
          end
          #redirect_to URI.escape("/facebook/post?name=#{title}&link=#{link}&pic=#{img}") and return
          #current_user.fb_page_graph.put_wall_post("test123 #test", {"name" => title, "link" => params[:link],
          #                        "caption" => "test", "description" => "description",
          #                        "picture" => img}, "192419394248940")
          messages = ["[#{title}]", page_description, "#{SITE_ROOT}/r?to=#{Base64.strict_encode64(link)}&obj=#{guid}&owner=#{yahoo_auction_id}"]
          current_user.fb_page_graph.put_picture(img, {:message => messages.join("\r\n\r\n")})
        end
      end
    end

    render :text => "OK" and return
  end

  def record
    Record.create!(link: Base64.decode64(params[:to]), guid: params[:obj], auction_id: params[:owner])
    
    redirect_to Base64.decode64(params[:to])
  end

  private 

      def top_location_redirect_script(url)
        return "<script>top.location.href='"+url+"'</script>"
      end

      def redirect_to_fb_site
        render inline: top_location_redirect_script(FB_APP_SITE)
      end

      def redirect_to_permission_page
        permissions = ['publish_actions', 'publish_stream', 'manage_pages']
 
        @oauth = Koala::Facebook::OAuth.new(FB_APP_ID, FB_SECRET, "#{SITE_ROOT}/oauth/facebook/callback")
        render inline: top_location_redirect_script(@oauth.url_for_oauth_code(permissions: permissions))
      end

      def allow_iframe_requests
        response.headers.delete('X-Frame-Options')
      end

      def get_permission_page
        permissions = ['publish_actions', 'publish_stream', 'manage_pages']
 
        @oauth = Koala::Facebook::OAuth.new(FB_APP_ID, FB_SECRET, "#{SITE_ROOT}/oauth/facebook/callback")
        @oauth.url_for_oauth_code(permissions: permissions)
      end
end
