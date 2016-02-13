require 'twitter'
require 'dotenv'
require './lib/parks'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CK"]
  config.consumer_secret     = ENV["TWITTER_CS"]
  config.access_token        = ENV["TWITTER_AT"]
  config.access_token_secret = ENV["TWITTER_AS"]
end

park, message = Parks.message

Parks.tweet(client, park, message)

