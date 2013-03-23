module Sunlight
  
  class CongressAPI
    def self.legislators_locate(lat, lng)
      response = HTTParty.get "http://congress.api.sunlightfoundation.com/legislators/locate", :query => {      
        :latitude => lat,
        :longitude => lng,
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response.parsed_response
    end
  end
  
end
