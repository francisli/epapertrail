module Sunlight
  
  class Congress
    
    URL_BASE = "http://congress.api.sunlightfoundation.com"
    
    def self.legislators_locate(lat, lng)
      response = HTTParty.get "#{URL_BASE}/legislators/locate", :query => {      
        :latitude => lat,
        :longitude => lng,
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response.parsed_response
    end
    
    def self.floor_updates(bioguide_id)
      response = HTTParty.get "#{URL_BASE}/floor_updates", :query => {      
        :legislator_ids__all => bioguide_id,
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response.parsed_response
    end
    
    def self.latest_vote(chamber)
      response = HTTParty.get "#{URL_BASE}/votes", :query => {      
        :chamber => chamber,
        :per_page => 1,
        :order => :voted_at__desc,
        :fields => 'voted_at,result,breakdown,voters,bill,question',
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response.parsed_response
    end
    
  end
  
end
