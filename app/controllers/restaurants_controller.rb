require '././lib/twitter_api'
require 'date'

class RestaurantsController < ApplicationController

    @@twitterAPI = TwitterAPI.new
  
    def index
        @restaurants = Restaurant.all          
        @@twitterAPI.get_all_tweets()   
        @tweets_all = @@twitterAPI.get_tweets_all()
        @tweet_all_time = @@twitterAPI.get_tweets_all_time()       
    end

    def show
        @restaurants = Restaurant.all
        @restaurant = Restaurant.find(params[:id])  
        @@twitterAPI.get_tweets(@restaurant.name)
        @tweets_one = @@twitterAPI.get_tweets_one()
        @tweets_one_time = @@twitterAPI.get_tweets_one_time()
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
