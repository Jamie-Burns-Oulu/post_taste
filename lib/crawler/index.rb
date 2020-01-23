require 'selenium-webdriver'
require_relative 'restaurants/juvenes'
require_relative 'restaurants/uniresta'

class WebCrawler
    def initialize()
        puts 'Initializing WebCrawler...'
        @list_of_restaurants = []
        @driver = {}
        setup_webdriver()
        get_menus()
        get_menus_twitter()
        get_menus_email()
    end

    def get_menus_twitter()
        list_of_tweets = format_tweet()
        return list_of_tweets
    end

    def get_menus_email()
        email_content = format_email()
        return email_content
    end

    private

    def setup_webdriver()
        options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
        @driver = Selenium::WebDriver.for(:chrome, options: options)
    end

    def get_menus()
        # JUVENES CHAIN
        juvenes = Juvenes.new(@driver)
        @list_of_restaurants.push(juvenes.get_restaurants())

        # UNIRESTA CHAIN
        uniresta = Uniresta.new(@driver)
        @list_of_restaurants.push(uniresta.get_restaurants())
        close_connection()
        @list_of_restaurants = @list_of_restaurants.flatten
    end
    
    def format_tweet()
        list_of_tweets = []
        max_menus = 6
        for restaurant in @list_of_restaurants do
            part_n_of_tweet = 1
            i = 1
            j = -1
            recommends = rand(1..restaurant.get_menus().length)
            tweet_title_are_many = restaurant.get_menus().length > max_menus
            tweet = ''
            tweet += "#{restaurant.get_restaurant_name()} #{ tweet_title_are_many ? "Part #{part_n_of_tweet}" : "" }\n"
            for menu in restaurant.get_menus() do
                if i > max_menus
                    j = j > i ? j : i
                    part_n_of_tweet += 1
                    # tweet += "\n#PT_recommends #{recommends}."
                    # tweet += "\n#PT_#{restaurant.get_restaurant_name().upcase}"
                    list_of_tweets.push(tweet)
                    i = 1
                    tweet = "#{restaurant.get_restaurant_name()} Part #{part_n_of_tweet}\n"
                end

                tweet += "#{i > j ? i : j}. #{menu}\n"
                i += 1
                j += 1
            end
            tweet += "\n#PT_recommends #{recommends}."
            tweet += "\n#PT_#{restaurant.get_restaurant_name().upcase}"
            list_of_tweets.push(tweet)
        end
        return list_of_tweets
    end
    
    def format_email()
        email = ''
        for restaurant in @list_of_restaurants do
            recommends = rand(1..restaurant.get_menus().length)
            email += "<h1>#{restaurant.get_restaurant_name()}</h1>"
            email+= "<ol>"
            for menu in restaurant.get_menus() do
                email += "<li>#{menu}</li>"
            end
            email += "</ol>"
            email += "<br>"
            email += "<a href='https://twitter.com/hashtag/PT_recommends'> #PT_recommends #{recommends}.</a>"
            email += "<a href='https://twitter.com/hashtag/#PT_#{restaurant.get_restaurant_name().upcase}'>#PT_#{restaurant.get_restaurant_name().upcase}</a>"
        end
        return email
    end
    def close_connection()
        @driver.quit
    end
end