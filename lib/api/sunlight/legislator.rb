module Sunlight
  
  class Legislator < Hashie::Mash
    
    def full_name
      if self.middle_name.blank?
        "#{self.first_name} #{self.last_name}"
      else
        "#{self.first_name} #{self.middle_name} #{self.last_name}"
      end        
    end
    
    def facebook_url
      "http://facebook.com/profile.php?id=#{self.facebook_id}"
    end
    
    def twitter_url
      "http://twitter.com/#{self.twitter_id}"
    end
    
    def youtube_url
      "http://youtube.com/#{self.youtube_id}"
    end
        
  end
  
end
