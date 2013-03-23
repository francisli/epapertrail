class HomeController < ApplicationController
  
  def index
    
  end
  
  def reps
    if session[:reps].blank?
      session[:reps] = Sunlight::CongressAPI.legislators_locate(session[:location][:lat], session[:location][:lng])
    end
    render :partial => 'reps'
  end
  
end
