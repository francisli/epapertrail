class HomeController < ApplicationController
  
  def index
    
  end
  
  def reps
    # fetch reps, if not set session
    session[:reps] = Sunlight::Congress.legislators_locate(session[:location][:lat], session[:location][:lng]) if session[:reps].blank?
    # fetch reps and speeches for specified chamber
    @reps = []
    @speeches = []
    session[:reps]['results'].each do |rep|
      if rep['chamber'] == params[:chamber]
        @reps << rep
        @speeches << Sunlight::CapitalWords.latest_speech(rep['bioguide_id'])
      end
    end
    render :partial => 'reps'
  end
  
  def votes
    result = Sunlight::Congress.latest_vote(params[:chamber])
    @vote = result['results'].first
    render :partial => 'votes'
  end
  
end
