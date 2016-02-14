require 'csv'

class Parks

  @@PARKS = {
    "RVP" => {
      "handle" => "Victoria",
      "name" => "Victoria Park"
    },
    "AVP" => {
      "handle" => "Avon",
      "name" => "Avon Park"
    },
    "RP" => {
      "handle" => "Rose",
      "name" => "Rosewarn Park"
    },
    "HGP" => {
      "handle" => "Hedge",
      "name" => "Hedgemead Park"
    },
    "AP" => {
      "handle" => "Alice",
      "name" => "Alice Park"
    },
    "KM" => {
      "handle" => "Ken",
      "name" => "Kensington Meadows"
    },
    "SG" => {
      "handle" => "Sydney",
      "name" => "Sydney Gardens"
    },
    "HP" => {
      "handle" => "Henrietta",
      "name" => "Henrietta Park"
    },
    "AXP" => {
      "handle" => "Alex",
      "name" => "Alexandra Park"
    },
    "SP" => {
      "handle" => "Spring",
      "name" => "Springfield Park"
    }
  }  
  
  def self.parks
    return @@PARKS
  end
  
  def self.choose
    return @@PARKS[ @@PARKS.keys.sample ]
  end
          
  def self.speak(client)
    park, message = Parks.message    
    tweet(client, park, message)     
  end

  def self.tweet(client, park, msg)
    if !msg.nil? && !msg.empty?
      status = "#{msg} ^#{park["handle"]}"
      client.update(status)
      puts status
    end
  end
        
  def self.retweet(client)
    parks.each do |id, park|
      puts "#{park["name"]} #bath"
      tweet = client.search("#{park["name"]} #bath").first
      if tweet && !tweet.media.empty?
        puts tweet.text
        begin
          client.retweet(tweet)
        rescue => e
          puts e
        end
      end
    end          
  end
  
  def self.amplify(client)
    begin
      client.friends.each do |friend|
        puts friend.screen_name
        tweet = client.user_timeline("@#{friend.screen_name}").first
        puts tweet.text
        if tweet && !tweet.media.empty?
          begin
            puts "retweet"
            client.retweet(tweet)
          rescue => e
            puts e
          end
        end        
      end
    rescue => e
      puts e      
    end
  end
  
  def self.message
    r = rand(0..2)
    case r
    when 0
      return facility
    when 1
      return fact
    when 2
      return random
    end  
  end

  @@FACILITIES = {}
    
  def self.facilities
    if @@FACILITIES.empty?
      CSV.foreach( File.join(File.dirname(__FILE__), "..", "etc", "parks.csv"), {headers: true}) do |row|
          @@FACILITIES[ row[0] ] = {
            "outdoor_sports" => row[4],
            "play_space" => row[5],
            "bowling_green" => row[7],
            "footpall_pitch" => row[8],
            "tennis_court" => row[11],
            "dog_bins" => row[14],
            "footpath" => row[15],
            "floral_display" => row[16],
            "play_facility" => row[17],
            "car_park" => row[21]  
          }
        end
    end
    @@FACILITIES
  end
    
  def self.facility
    message_type = @@FACILITY_MESSAGES.keys.sample    
    park = choose
    while facilities[ park["handle"] ][message_type] == "N"
      park = choose
    end
    return park, @@FACILITY_MESSAGES[message_type].sample
  end

  @@FACILITY_MESSAGES = {
    "outdoor_sports" => [
      "Did you know I have space for outdoor sports?",
      "I'd be happy if you want to come play some sports",
      "I like sports"
    ],
    "play_space" => [
      "I have space for children to play!",
      "I contain a children's play space",
      "Come a let the children burn off some energy!"
    ],
    "bowling_green" => [
      "Did you know I have a bowling green?",
      "Fancy a game of bowls?",
      "How about some crown green bowling this weekend?"
    ],
    "football_pitch" => [
      "Come play football!",
      "Did you know I have a football pitch?",
      "Plenty of goals scored on my football pitch"
    ],
    "tennis_court" => [
      "There are tennis courts here you know",
      "Did you know I have tennis courts?",
      "I like tennis"
    ],
    "dog_bins" => [
      "Dogs are welcome!",
      "I like dogs",
      "I love it when people come to walk their dogs"
    ],
    "footpath" => [
      "Come walk along my footpaths"
    ],
    "floral_display" => [
      "I have floral displays in summer",
      "Flowers really brighten up the place"
    ],
    "play_facility" => [
      "There's a play facility here",
      "Did you know I have a play facility?",
      "Kids are very welcome!"
    ],
    "car_park" => [
      "I have a car park, if you're bring the family",
      "You can park here for a day out",
      "Did you know I have a car park?"
    ]      
  }

  def self.fact
    handle = @@FACTS.keys.sample    
    park = @@PARKS[handle]
    return park, @@FACTS[handle].sample
  end
    
  @@FACTS = {
    "RVP" => [
      "I'm so famous I have a wikipedia page. https://en.wikipedia.org/wiki/Royal_Victoria_Park,_Bath",
      "I was opened in 1830 you know. By a princess!",
      "I'm the largest park in Bath you know. 57 acres for you to enjoy",
      "Princess Victoria was 11 years old when she opened me. Lovely girl",
      "Have you been to the Great Dell?",
      "The council have written about me here: http://www.bathnes.gov.uk/services/sport-leisure-and-parks/parks-opening-times-and-locations/royal-victoria-park",
      "Here's how my lake looked in 1898. Fond memories https://www.flickr.com/photos/britishlibrary/11294343804",
      "The obelisk in 1898 https://www.flickr.com/photos/britishlibrary/11295105756",
      "I used to have a dairy on-site in 1898. Fresh milk! https://www.flickr.com/photos/britishlibrary/11293644394",
      "How visitors would have seen me in 1898 https://www.flickr.com/photos/britishlibrary/11293297916",
      "Looking at the Royal Crescent from Park Avenue in 1898 https://www.flickr.com/photos/britishlibrary/11293015256",
      "A walk along my Park Avenue in 1898 https://www.flickr.com/photos/britishlibrary/11292152153"      
    ],
    "AVP" => [
      "I may be small, but I make a nice rest stop for a walk down the river"
    ],
    "RP" => [
      "I'm in the heart of a community in Whiteway",
      "Community Play Rangers started right here! http://www.bapp.org.uk/play-provision/community-play-rangers/"
    ],
    "HGP" => [
      "Some nice words written about me here: http://www.bathnes.gov.uk/services/sport-leisure-and-parks/parks-opening-times-and-locations/hedgemead-park",
      "There's an awesome community growing space here! @vegmead",
      "I opened in 1889. Have been fabulous ever since!",
      "There are some beautiful roses growing here",
      "It's steep here, so not suitable for wheelchairs I'm afraid",
      "Follow @vegmead to stay in touch with my community growers :)"
    ],
    "AP" => [
      "Hey, there's a cafe here if you fancy some tea & cake! http://www.alicepark.co.uk/",
      "Get the low down on me from the council http://www.bathnes.gov.uk/services/sport-leisure-and-parks/parks-opening-times-and-locations/alice-park",
      "I might only be 8 acres but there's a lovely childrens play area",
      "I'm the youngest park in Bath! Opened in 1937!!",
      "I love having a nursery here! Kids are awesome! @aliceparknurse"
    ],
    "KM" => [
      "Visitor details from Natural England http://www.lnr.naturalengland.org.uk/Special/lnr/lnr_details.asp?C=0&N=&ID=984",
      "You can walk along the river here",
      "I have a lovely mosaic of habitats, come and see the wildlife",
      "Bring some binoculars and try to see the kingfishers",
      "I'm a good place to see Kingfishers"
    ],
    "SG" => [
      "I'm so famous I've got my own wikipedia page: https://en.wikipedia.org/wiki/Sydney_Gardens",
      "I'm the oldest park in Bath dating back to 1792",
      "I'm the only remaining 18th Century pleasure gardens in Bath",
      "Nice words by the council: http://www.bathnes.gov.uk/services/sport-leisure-and-parks/parks-opening-times-and-locations/sydney-gardens",
      "John Nixon painted a nice picture of me in 1801. Lovely chap http://www.britishmuseum.org/research/collection_online/collection_object_details.aspx?objectId=751303&partId=1&place=39438&plaA=39438-1-4&page=1"
    ],
    "HP" => [
      "Visit Bath have written about me: http://visitbath.co.uk/things-to-do/henrietta-park-p25071",
      "I opened in 1897",
      "I'm 7 acres, small but awesome",
      "So this happened (in 1967!) https://www.youtube.com/watch?v=iR5cP02oO6I"  
    ],
    "AXP" => [
      "I have my own website! http://www.alexandraparkbath.org/",
      "I was opened in 1902",
      "I'm 11 acres",
      "I have the absolute best views of the city",
      "If you fancy a workout, try walking up Jacob's Ladder",
      "If you need any info, check the council website: http://www.bathnes.gov.uk/services/sport-leisure-and-parks/parks-opening-times-and-locations/alexandra-park",
      "People love me so much they're sharing photos on @alexandrapark3",
      "Compare today's view with this one from 1718 http://www.britishmuseum.org/research/collection_online/collection_object_details.aspx?objectId=752821&partId=1&place=39438&plaA=39438-1-4&page=1"
    ],
    "SP" => [
      "I have some woods for you to play in",
      "I've got a Green Flag award :)",
      "There are regular community events here. I love having people around"
    ]    
  }
      
  def self.random
    park = choose
    return park, "When was the last time you visited #{park["name"]}?" 
  end
    
  
end
