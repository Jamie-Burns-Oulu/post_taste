require './lib/twitter_api'
require './lib/crawler/Tweeter'
require './lib/crawler/test_crawler'
require '././app/mailers/daily_email'

twitter_api = TwitterAPI.new
daily_email = DailyEmail.new

#TODO Combine tasks into one cronjob, order to be 1.web-scrape 2.tweet 3.email

namespace :twitter_cron do
   desc "Get tweets using hastag"
   task get_tweets: :environment do
      puts "Getting tweets..."    
      twitter_api.get_tweets
      puts "Done"
   end
   desc "Test webdriver"
   task test_webdriver: :environment do
      puts "Test cron starting.."
      WebCrawlerTest.new
      puts "Test cron ended."
   end
   desc "Post tweet"
   task post_tweet: :environment do
      puts 'Cron job is waking up...'
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
      daily_email.run
      puts "Emails sent"
   end
end 
