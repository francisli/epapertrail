module Sunlight
  
  class Congress
    
    URL_BASE = "https://congress.api.sunlightfoundation.com"
    
    def self.legislators_locate(lat, lng)
      response = HTTParty.get "#{URL_BASE}/legislators/locate", :query => {      
        :latitude => lat,
        :longitude => lng,
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response.parsed_response
    end
    
    def self.legislators_in_office(chamber)
      response = HTTParty.get "#{URL_BASE}/legislators", :query => {
        :chamber => chamber,
        :per_page => :all,
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response.parsed_response
    end
    
    def self.legislator(bioguide_id)
      response = HTTParty.get "#{URL_BASE}/legislators", :query => {
        :bioguide_id => bioguide_id,
        :all_legislators => true,
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response = response.parsed_response
      if response['results'] && response['results'].length == 1
        Legislator.new response['results'][0]
      else
        nil
      end
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
    
    def self.votes_by_legislator(bioguide_id, page = 1)
      response = HTTParty.get "#{URL_BASE}/votes", :query => {
        :"voter_ids.#{bioguide_id}__exists" => :true,
        :order => :voted_at__desc,
        :fields => 'voted_at,result,breakdown,voter_ids,bill,question',
        :page => page,
        :per_page => 50,
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response.parsed_response
    end
    
    def self.votes_with_legislators(bioguide_id1, bioguide_id2, page = 1)
      response = HTTParty.get "#{URL_BASE}/votes", :query => {
        :"voter_ids.#{bioguide_id1}__exists" => :true,
        :"voter_ids.#{bioguide_id2}__exists" => :true,
        :order => :voted_at__desc,
        :fields => 'voted_at,result,breakdown,voter_ids,bill,question',
        :page => page,
        :per_page => 50,
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response.parsed_response
    end
    
    def self.bills_cosponsored(bioguide_id1, bioguide_id2, page = 1)
      response = HTTParty.get "#{URL_BASE}/bills", :query => {
        :cosponsor_ids__all => "#{bioguide_id1}|#{bioguide_id2}",
        :order => :introduced_on__desc,
        :page => page,
        :per_page => 50,
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response.parsed_response
    end    
  end
  
end
