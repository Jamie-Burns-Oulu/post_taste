require './lib/twitter_api'
twitter_api = TwitterAPI.new

namespace :twitter_cron do
   desc "Get tweets using hastag"
   task get_tweets: :environment do
      puts "Getting tweets..."    
      twitter_api.get_tweets
      puts "Done"
   end
   desc "Post tweet"
   task post_tweet: :environment do
      puts "Posting tweet..."     
      twitter_api.post_tweet(p ENV['tweet'])
      puts "Done"
   end
end