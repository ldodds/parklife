require 'csv'

class Parks

  @@PARKS = {
    "RVP" => {
      "handle" => "Victoria",
      "name" => "Royal Victoria Park"
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
  
  @@FACILITIES = {}
    
  def self.parks
    return @@PARKS
  end
  
  def self.choose
    return @@PARKS[ @@PARKS.keys.sample ]
  end
  
  def self.tweet(client, park, msg)
    status = "#{msg} ^#{park["handle"]}"
    if !status.nil?
      client.update(status) unless status.nil?
      puts status
    end
  end
  
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
      "Dog are welcome!",
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
      "Kids are awesome!"
    ],
    "car_park" => [
      "I have a car park, if you're bring the family",
      "You can park here for a day out",
      "Did you know I have a car park?"
    ],      
  }
  
  @@FACTS = {
    "RVP" => [
      "Here's my wikipedia page. https://en.wikipedia.org/wiki/Royal_Victoria_Park,_Bath",
      "I opened in 1830 you know",
      "I've got 57 acres of space for you to enjoy",
      "Princess Victoria was 11 years old when she opened me",
      "Have you been to the Great Dell?",
      "Read more about me here: http://www.bathnes.gov.uk/services/sport-leisure-and-parks/parks-opening-times-and-locations/royal-victoria-park"
    ],
    "AVP" => [
      
    ],
    "RP" => [
      "I'm in the heart of a community in Whiteway",
      "Community Play Rangers started right here: http://www.bapp.org.uk/play-provision/community-play-rangers/"
    ],
    "HGP" => [
      "Read more about me here: http://www.bathnes.gov.uk/services/sport-leisure-and-parks/parks-opening-times-and-locations/hedgemead-park",
      "There's a community growing space here",
      "I opened in 1889",
      "There are beautiful roses here",
      "It's steep here, so not suitable for wheelchairs I'm afraid"
    ],
    "AP" => [
      "Did you know there's a cafe here? http://www.alicepark.co.uk/",
      "Read more about me here: http://www.bathnes.gov.uk/services/sport-leisure-and-parks/parks-opening-times-and-locations/alice-park",
      "I'm 8 acres and have a space for children to play",
      "I opened in 1937"
    ],
    "KM" => [
      "Read more about me here: http://www.lnr.naturalengland.org.uk/Special/lnr/lnr_details.asp?C=0&N=&ID=984",
      "You can walk along the river here",
      "I'm a good place to see Kingfishers"
    ],
    "SG" => [
      "Here's my wikipedia page: https://en.wikipedia.org/wiki/Sydney_Gardens",
      "I was created in 1792. The oldest park in Bath",
      "I'm the only remaining 18th Century pleasure gardens in Bath",
      "Read more about me here: http://www.bathnes.gov.uk/services/sport-leisure-and-parks/parks-opening-times-and-locations/sydney-gardens"
    ],
    "HP" => [
      "Read more about me here: http://visitbath.co.uk/things-to-do/henrietta-park-p25071",
      "I was opened in 1897",
      "I'm 7 acres"  
    ],
    "AXP" => [
      "I have my own website! http://www.alexandraparkbath.org/",
      "I was opened in 1902",
      "I'm 11 acres",
      "I have the best views of the city",
      "If you fancy a workout, try walking up Jacob's Ladder",
      "Read more about me here: http://www.bathnes.gov.uk/services/sport-leisure-and-parks/parks-opening-times-and-locations/alexandra-park"
    ],
    "SP" => [
      
    ]    
  }
  
  def self.fact
    handle = @@FACTS.keys.sample    
    park = @@PARKS[handle]
    return park, @@FACTS[handle].sample
  end
    
  def self.random
    park = choose
    return park, "When was the last time you visited #{park["name"]}?" 
  end
  
  
end
