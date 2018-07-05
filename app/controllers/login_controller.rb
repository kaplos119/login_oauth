# login via oauth controller
class LoginController < ActionController::Base
  def index
    @client_id = ENV['client_id']
  end

  def callback_handling
    @client_id = ENV['client_id']
    @client_secret = ENV['client_secret']
    @timeout_flag = false
    @request_failure = false
    require 'net/https'
    require 'open-uri'
    require 'uri'
    require 'cgi'
    require 'timeout'
    begin
        Timeout.timeout(50) do
         uri = URI.parse(URI.encode("https://github.com/login/oauth/access_token?client_id=#{@client_id}&client_secret=#{@client_secret}&code=#{params['code']}"))
         http = Net::HTTP.new(uri.host, uri.port)
         http.use_ssl = true
         http.verify_mode = OpenSSL::SSL::VERIFY_NONE
         request = Net::HTTP::Post.new(uri.request_uri)
         response = http.request(request)
         response_body = CGI.parse(response.body)
         Rails.logger.error "********#{response.code}*****#{response_body}*******"
         if (response.code == '200') && (response_body.key? 'access_token')
           uri = URI.parse(URI.encode("https://api.github.com/user/repos?access_token=#{response_body['access_token'].last}"))
           http = Net::HTTP.new(uri.host, uri.port)
           http.use_ssl = true
           http.verify_mode = OpenSSL::SSL::VERIFY_NONE
           request = Net::HTTP::Get.new(uri.request_uri)
           response_1 = http.request(request)
           Rails.logger.error "*********#{response_1.code}********#{response_1.body}***"
           @repos_hash = {}
           if response_1.code == '200'
             body_hash = JSON.parse(response_1.body)
             body_hash.each_with_index do |body, i|
               local_hash = {}
               local_hash['name'] = body['name']
               local_hash['description'] = body['description']
               local_hash['private'] = body['private']
               @repos_hash[i] = local_hash
             end
           end
         else
           @request_failure = true
         end
        end
    rescue Timeout::Error
       @timeout_flag = true
    end
  end
end
