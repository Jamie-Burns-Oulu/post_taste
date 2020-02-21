require 'twitter'

class TwitterAPI 

  ##TODO make date-checker one function

  def initialize()
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["consumer_key"]
      config.consumer_secret     = ENV["consumer_secret"]
      config.access_token        = ENV["access_token"]
      config.access_token_secret = ENV["access_token_secret"]
    end 

 end  
 
  @@time = Time.new
  @@timeString = @@time.strftime("%Y-%m-%d")  
  @@tweets_one = []
  @@tweets_one_time = [] 
  @@tweets_all = []
  @@tweets_all_time = []

  def get_all_tweets() 
    @@tweets_all = []
    @@tweets_all_time = []
    @client.search("from:post_taste}").take(20).each do | tweet |
      @createdString = tweet.created_at.to_s
      if @createdString[0..9] == @@timeString 
        @@tweets_all.push(tweet.full_text)
        @@tweets_all_time.push(tweet.created_at)
      end 
    end    
  return  @@tweets_all, @@tweets_all_time
  end

  def get_tweets_all()
    return @@tweets_all
  end 

  def get_tweets_all_time()
    return @@tweets_all_time
  end 

  
  def get_tweets(res)     
    @@tweets_one = []
    @@tweets_one_time = [] 
    @client.search("from:post_taste #{res}").take(10).each do | tweet|
      # Checking tweets creation date against today's date   
      @createdString = tweet.created_at.to_s
      if @createdString[0..9] == @@timeString 
        @@tweets_one.push(tweet.full_text)
        @@tweets_one_time.push(tweet.created_at)
      end 
    end      
    return @@tweets_one, @@tweets_one_time
  end

  def get_tweets_one()
    return @@tweets_one
  end 

  def get_tweets_one_time()
    return @@tweets_one_time
  end 

  def post_tweet(content)
    @client.update("#{content}")
  end
  
end