class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_location
  
  private
  
  def set_location
    if session[:location].blank?
      result = GeoIP.lookup.city(request.ip)
      if result and result[:country_code2] == "US"
        session[:location] = {
          :lat => result[:latitude],
          :lng => result[:longitude]
        }
      else
        session[:location] = {
          :lat => 37.789800000000014,
          :lng => -122.3942
        }
      end
    end
  end
  
end
