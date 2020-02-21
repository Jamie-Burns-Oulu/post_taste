require '././lib/twitter_api'

class UserMailer < ApplicationMailer

  @@twitterAPI = TwitterAPI.new

  default from: 'notifications@example.com'

  def welcome_email  
    @@twitterAPI.get_all_tweets()   
    @tweets_all = @@twitterAPI.get_tweets_all()
    @tweets_all_time = @@twitterAPI.get_tweets_all_time() 
    @user = params[:user]  
    mail(to: @user.email, subject: 'Welcome to PostTaste')
  end

  def daily_summary            
    @@twitterAPI.get_all_tweets()   
    @tweets_all = @@twitterAPI.get_tweets_all()
    @tweets_all_time = @@twitterAPI.get_tweets_all_time()
    @@twitterAPI.get_all_tweets()  
    @email = params[:email] 
    mail(to: @email, subject: 'PostTaste Daily Summary')  
  end

end
