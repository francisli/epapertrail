class RepsController < ApplicationController
  
  def show
    @legislator = Sunlight::Congress.legislator params[:id]
  end
  
  def floor
    @speeches = Sunlight::CapitalWords.speeches params[:id]
    render partial: 'reps/floor'
  end
  
  def bills
    render partial: 'reps/bills'
  end
  
  def votes_against
    render partial: 'reps/votes_against'
  end
  
end
