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

#Choose a park to speak and let it say something
#will be either facility, a fact, or something random
Parks.speak(client)

#non specific, retweet latest tweet about the park with #bath, if they have photos
Parks.retweet(client)

#non specific, retweet latest tweet of followers if they have photos
Parks.amplify(client)
