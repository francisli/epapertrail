# Add an initialized singleton instance with accessor to the GeoIP class
#
class GeoIP
  @@singleton = GeoIP.new("#{Rails.root}/public/GeoLiteCity.dat")
  
  def self.lookup
    @@singleton
  end
  
end
