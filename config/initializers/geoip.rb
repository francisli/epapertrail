# Add an initialized singleton instance with accessor to the GeoIP class
#
class GeoIP
  @@singleton = nil
  
  def self.lookup
    @@singleton = GeoIP.new("#{Rails.root}/public/GeoLiteCity.dat") if @@singleton.nil?
    @@singleton
  end
  
end
