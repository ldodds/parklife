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

intros = [
  "Hey,", "Excited to be here.", "Is this thing on?", "Looking forward to chatting!",
  "Hello twitter!", "Hi!", "Welcome to Bath Park Life.", "My first tweet!", "*taps mic* ", "Hiya,"
]

Parks.parks.each do |handle, park|
  client.update("#{intros.shuffle!.pop} I'm #{park["name"]} & I'll be tweeting as ^#{park["handle"]}")
  #puts "#{intros.shuffle!.pop} I'm #{park["name"]} & I'll be tweeting as ^#{park["handle"]}"
end