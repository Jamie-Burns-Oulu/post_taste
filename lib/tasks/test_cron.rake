require './lib/twitter_api'
require './lib/email_sender'
require './lib/crawler/Tweeter'

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
      today = Date.today.strftime("%A")
      if today != 'Saturday' && today != 'Sunday'
         puts "Tweet posting cron job is starting..."  
         tweeter = Tweeter.new
         tweeter.post_tweets()
         puts "Cron job done"
      else
         puts 'Today is a weekend => no tweet.'
      end
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
