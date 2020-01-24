require_relative 'index'
require_relative '../twitter_api'

class Tweeter

    def initialize
        @crawler = WebCrawler.new
        @twitter = TwitterAPI.new
        @list_of_tweets = []
        get_tweets()
    end

    def post_tweets
        puts "Tweeter is tweeting..."
        for tweet in @list_of_tweets do
            @twitter.post_tweet(tweet)
        end
        puts "#{@list_of_tweets.length} tweets tweeted."
    end

    private

    def get_tweets
        @list_of_tweets = @crawler.get_menus_twitter()
    end

end
