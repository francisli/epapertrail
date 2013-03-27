module Sunlight
  
  class CapitalWords
    
    URL_BASE = "http://capitolwords.org/api/1"
    
    def self.latest_speech(bioguide_id)
      response = HTTParty.get "#{URL_BASE}/text.json", :query => {      
        :bioguide_id => bioguide_id,
        :sort => 'id desc',
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      # iterate through, looking for speeches more than 2 lines long
      latest_speech = nil
      response.parsed_response['results'].each do |speech|
        latest_speech = speech
        break if speech['speaking'].length > 2
      end
      latest_speech
    end
    
  end
  
end
