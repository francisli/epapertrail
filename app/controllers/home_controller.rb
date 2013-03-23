class HomeController < ApplicationController
  
  def index
    
  end
  
  def reps
    if session[:reps].blank?
      session[:reps] = Sunlight::Congress.legislators_locate(session[:location][:lat], session[:location][:lng])
    end
    render :partial => 'reps'
  end
  
  def votes
    result = Sunlight::Congress.latest_vote(params[:chamber])
    @vote = result['results'].first
    render :partial => 'votes'
  end
  
end
