require '././lib/twitter_api'

class UserMailer < ApplicationMailer

  @@time = Time.new
  @@timeString = @@time.strftime("%Y-%m-%d")     
  @@twitterAPI = TwitterAPI.new

   default from: 'notifications@example.com'
 
   def welcome_email
     @user = params[:user]
     @restaurants = Restaurant.all             

     @tweets_all = Array[]

     @@twitterAPI.get_all_tweets().each do |tweet|          
         # Checking tweets creation date against today's date             
         @createdString = tweet.created_at.to_s
         if @createdString[0..9] == @@timeString 
             @tweets_all.push(tweet.full_text)
         end            
     end
     mail(to: @user.email, subject: 'Welcome to PostTaste')
   end
 
   
end
