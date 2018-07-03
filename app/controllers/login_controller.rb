class LoginController < ActionController::Base
  def index
  	byebug
  	@client_id = ENV['client_id']
  end

  def callback_handling
  	byebug
  	@client_id = ENV['client_id']
  	@client_secret = ENV['client_secret']
  	require 'net/https'
    require 'open-uri'
    require 'uri'
    uri = URI.parse(URI::encode("https://github.com/login/oauth/access_token?client_id=#{@client_id}&client_secret=#{@client_secret}&code=#{params['code']}"))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    response = http.request(request)
    byebug
  end
end