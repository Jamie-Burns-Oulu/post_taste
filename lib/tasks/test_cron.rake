require './lib/twitter_api'
require './lib/email_sender'

twitter_api = TwitterAPI.new
email_sender = MenuEmailer.new

#TODO Combine tasks into one cronjob, order to be 1.web-scrape 2.tweet 3.email

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

namespace :email_cron do 
   desc "Send emails using email_sender"
   task send_emails: :environment do 
      puts "Sending emails..."
      email_sender.send_mail
      puts "Emails sent"
   end
end 
