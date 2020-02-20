require '././lib/twitter_api'
require 'date'

class RestaurantsController < ApplicationController

    @@time = Time.new
    @@timeString = @@time.strftime("%Y-%m-%d")     
    @@twitterAPI = TwitterAPI.new
  
    def index
        @restaurants = Restaurant.all             

        @tweets_all = Array[]
        @tweet_time = Array[]
        @@twitterAPI.get_all_tweets().each do |tweet|          
            # Checking tweets creation date against today's date             
            @createdString = tweet.created_at.to_s
            if @createdString[0..9] == @@timeString 
                @tweets_all.push(tweet.full_text)
                @tweet_time.push(tweet.created_at)
            end            
        end
    end

    def show
        @restaurants = Restaurant.all
        @restaurant = Restaurant.find(params[:id])      

        @tweets_one = Array[]
        @tweets_time = Array[]

        @@twitterAPI.get_tweets(@restaurant.name).each do |tweet|  
            # Checking tweets creation date against today's date   
            @createdString = tweet.created_at.to_s
            if @createdString[0..9] == @@timeString 
                @tweets_one.push(tweet.full_text)
                @tweets_time.push(tweet.created_at)
            end        
        end
    end

    def create
        @restaurant = Restaurant.new(res_params)
        
        if @restaurant.save
          redirect_to @restaurant
        else
          render 'new'
        end
      end

    def new
    end

    private
    def res_params
      params.require(:restaurant).permit(:name)
    end

end
