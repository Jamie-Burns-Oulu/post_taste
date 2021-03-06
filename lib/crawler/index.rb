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
        puts 'Setting up webdriver'
        options = Selenium::WebDriver::Chrome::Options.new
        puts "chromedriver ENV: #{ENV.fetch('GOOGLE_CHROME_SHIM', nil)}"
        chrome_bin_path = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
        options.binary = chrome_bin_path if chrome_bin_path
        options.add_argument('--headless')
        @driver = Selenium::WebDriver.for :chrome, options: options
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
        emoji_array = ['🍴', '🍽', '🍕', '🍗', '🍔', '🍰', '🌮', '🥗', '🥩', '🥦', '🥓', '🥨', '🍻', '🌯', '🍩', '🍤']
        if @list_of_restaurants.length
            for restaurant in @list_of_restaurants do
                if restaurant.get_menus().length
                    part_n_of_tweet = 1
                    i = 1
                    j = -1
                    recommends = rand(1..restaurant.get_menus().length)
                    max_length_of_menus = restaurant.get_menus().length > max_menus
                    emoji = emoji_array[rand(0..emoji_array.length-1)]
                    tweet = ''
                    tweet += "#{restaurant.get_restaurant_name().upcase} #{ max_length_of_menus ? "Part #{part_n_of_tweet}" : "" } #{emoji}\n\n"
                    for menu in restaurant.get_menus() do
                        emoji = emoji_array[rand(0..emoji_array.length-1)]
                        if i > max_menus || tweet.length >= 230
                            j = j > i ? j : i
                            part_n_of_tweet += 1
                            tweet += "\n#PT_#{restaurant.get_restaurant_name().upcase}"
                            list_of_tweets.push(tweet)
                            i = 1
                            tweet = "#{restaurant.get_restaurant_name().upcase} Part #{part_n_of_tweet} #{emoji}\n\n"
                        end
                        tweet += "#{i > j ? i : j}. #{menu}\n"
                        i += 1
                        j += 1
                    end
                    tweet += "\n#PT_RECOMMENDS #{recommends} 🔥"
                    tweet += "\n#PT_#{restaurant.get_restaurant_name().upcase}"
                    list_of_tweets.push(tweet)
                end
            end
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