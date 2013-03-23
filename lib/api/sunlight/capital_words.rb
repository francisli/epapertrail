module Sunlight
  
  class CapitalWords
    
    URL_BASE = "http://capitolwords.org/api/1"
    
    def self.text(bioguide_id)
      response = HTTParty.get "#{URL_BASE}/text.json", :query => {      
        :bioguide_id => bioguide_id,
        :order => :date__desc,
        :start_date => '2013-03-01',
        :apikey => ENV['SUNLIGHT_API_KEY']
      }
      response.parsed_response
    end
    
  end
  
end
