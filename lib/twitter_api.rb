require 'twitter'

class TwitterAPI 

  def initialize()
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["consumer_key"]
      config.consumer_secret     = ENV["consumer_secret"]
      config.access_token        = ENV["access_token"]
      config.access_token_secret = ENV["access_token_secret"]
    end 
 end  
  
  def get_tweets() 
    @client.search('#PT_FOODOO').take(3).each do |tweet|
      puts tweet.full_text
    end
  end

  def post_tweet(content)
    @client.update("#{content}")
  end
  
end