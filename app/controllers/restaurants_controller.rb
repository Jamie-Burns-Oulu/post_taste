require '././lib/twitter_api'

class RestaurantsController < ApplicationController

    def index
        @restaurants = Restaurant.all
    end

    def show
        @time = Time.new
        @timeString = @time.strftime("%Y-%m-%d")

        @twitterAPI = TwitterAPI.new
        @tweets_array = Array[]

        @restaurant = Restaurant.find(params[:id])
        @restaurants = Restaurant.all

        @twitterAPI.get_tweets(@restaurant.name).each do |tweet|  
            # Checking tweets creation date against today's date   
            @createdString = tweet.created_at.to_s
            if @createdString[0..9] == @timeString 
                @tweets_array.push(tweet.full_text)
            end 
        end
    end


end
