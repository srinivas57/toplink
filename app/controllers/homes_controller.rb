 require 'uri'
class HomesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "ax0KXaJJgP7DJs8bGr5iGkKDi"
      config.consumer_secret     = "iW7LGTKkP1XtwEYycR2sBBk1lcAimgAiq8nlpFyGUEqDCiaUtY"
    end
    if current_user.tweetlists == []
      @twitter_client.user_timeline(current_user.uname).each do |tweet|
        if  URI.extract(tweet.text, ['http', 'https']).present?
          if ((tweet.created_at) > (Date.today-7))
            new_tweet = Tweetlist.new()
            new_tweet.content = tweet.text
            new_tweet.user = current_user
            new_tweet.save
          end  
        end
      end     
    end   
  end  
end
